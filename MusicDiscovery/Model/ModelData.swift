//
//  ModelData.swift
//  MusicDiscovery
//
//  Created by 舘岡龍之介 on 2022/07/24.
//

import MusicKit
import MediaPlayer
import Foundation
import SwiftUI

final class ModelData: ObservableObject {
    @Published var musicTracks = [MusicTrack]()
    @Published var currentTrack: MusicTrack?
    @Published var isPlaying = false
    @Published var isSelected = false
    @Published var isSearching = false
    @Published var searchQuery: String = ""
    @Published var libraryPlaylists = [MusicPlaylist]()
    
    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    
    @MainActor
    init() {
        loadLibraryPlaylist()
    }
    
    @MainActor
    private func loadLibraryPlaylist(){
        Task {
            let status = await MusicAuthorization.request()
            switch status {
            case .authorized:
                do {
                    if #available(iOS 16.0, *) {
                        var request = MusicLibraryRequest<Playlist>()
                        request.sort(by: \.lastPlayedDate, ascending: false)
                        let response = try await request.response()
                        let playlists = response.items
                        fetchMusicTracksInPlaylist(playlists: playlists)
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
    
    @MainActor
    private func fetchMusicTracksInPlaylist(playlists: MusicItemCollection<Playlist>)  {
        Task {
            do {
                for playlist in playlists {
                    let detailedPlaylist = try await playlist.with(.tracks, preferredSource: .library)
                    print("*** Detailed Plaulist ***")
                    print("\(detailedPlaylist)")
                    let libraryPlaylist = MusicPlaylist(
                        id: detailedPlaylist.id.rawValue,
                        name: detailedPlaylist.name,
                        imageUrl: detailedPlaylist.artwork?.url(width: 75, height: 75),
                        lastPlayedDate: detailedPlaylist.lastPlayedDate,
                        musicTracks: getMusicTracksInPlaylist(playlist: detailedPlaylist))
                    self.libraryPlaylists.append(libraryPlaylist)
                }
            }
        }
    }
    
    private func getMusicTracksInPlaylist(playlist: Playlist) -> [MusicTrack] {
        var musicTracks = [MusicTrack]()
        playlist.tracks?.forEach { track in
            musicTracks.append(MusicTrack(
                id: track.id.rawValue,
                name: track.title,
                artist: track.artistName,
                imageUrl: track.artwork?.url(width: 75, height: 75)
            ))
        }
        print("*** music tracks in playlist ***")
        print("\(playlist.tracks)")
        return musicTracks
    }
}


