//
//  ModelData.swift
//  MusicDiscovery
//
//  Created by 舘岡龍之介 on 2022/07/24.
//

import MusicKit
import MediaPlayer
import Foundation

final class ModelData: ObservableObject {
    @Published var musicTracks = [MusicTrack]()
    @Published var currentTrack: MusicTrack?
    @Published var isPlaying = false
    @Published var isSelected = false
    @Published var isSearching = false
    @Published var searchQuery: String = ""
    @Published var libraryPlaylists = [MusicPlaylist]()
    
    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    
    init() {
        loadLibraryPlaylist()
    }
    
    private func loadLibraryPlaylist(){
        Task {
            let status = await MusicAuthorization.request()
            switch status {
            case .authorized:
                do {
                    if #available(iOS 16.0, *) {
                        let request = MusicLibraryRequest<Playlist>()
                        let response = try await request.response()
                        self.libraryPlaylists = response.items.compactMap({
                            return .init(
                                id: $0.id.rawValue,
                                name: $0.name,
                                imageUrl: $0.artwork?.url(width: 75, height: 75),
                                lastPlayedDate: $0.lastPlayedDate
                            )
                        })
                        self.libraryPlaylists = sortPlaylistsByLastPlayedDate(playlists: libraryPlaylists)
                    } else {
                        // Fallback on earlier versions
                    }
                } catch {
                    print(String(describing: error))
                }
            default:
                break
            }
        }
    }
    
    private func sortPlaylistsByLastPlayedDate(playlists: [MusicPlaylist]) -> [MusicPlaylist] {
        return playlists.sorted { (a, b) -> Bool in
            switch (a.lastPlayedDate, b.lastPlayedDate) {
            case (.some, .some):
                return a.lastPlayedDate! > b.lastPlayedDate!

            case (.some, .none):
                return true

            case (.none, _):
                return false
            }
        }
    }
    
    private func generateSearchRequest(searchQuery: String) -> MusicCatalogSearchRequest {
        var request = MusicCatalogSearchRequest(term: searchQuery, types: [Song.self])
        request.limit = 25
        return request
    }

    func searchMusicTracks(searchQuery: String) {
        Task {
            let status = await MusicAuthorization.request()
            switch status {
            case .authorized:
                do {
                    let result = try await generateSearchRequest(searchQuery: searchQuery).response()
                    self.musicTracks = result.songs.compactMap({
                        return .init(
                            id: $0.id.rawValue,
                            name: $0.title,
                            artist: $0.artistName,
                            imageUrl: $0.artwork?.url(width: 75, height: 75)
                        )
                    })
                    print(String(describing: musicTracks[0]))
                } catch {
                    print(String(describing: error))
                }
            default:
                break
            }
        }
    }
}


