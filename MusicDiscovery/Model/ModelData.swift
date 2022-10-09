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
    @Published var musicTracks = MusicItemCollection<Song>()
    @Published var currentTrack: Song?
    @Published var isPlaying = false
    @Published var isSelected = false
    @Published var isSearching = false
    @Published var searchQuery: String = ""
    @Published var libraryPlaylists = [MusicPlaylist]()
    @Published var latestThreePlaylists = [MusicPlaylist]()
    
    @Environment(\.isSearching) private var searchStatus
    @Published var playbackBarSpacerHeight = 7 / 100 * UIScreen.main.bounds.size.height
    
    var musicPlayer = ApplicationMusicPlayer.shared
    
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
                    self.musicTracks = result.songs
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
                        musicTracks: convertTracksToSongs(tracks: detailedPlaylist.tracks)
                    )
                    if self.latestThreePlaylists.count < 3 {
                        self.latestThreePlaylists.append(libraryPlaylist)
                        self.libraryPlaylists.append(libraryPlaylist)
                    } else {
                        self.libraryPlaylists.append(libraryPlaylist)
                    }
                }
            }
        }
    }
    
    private func convertTracksToSongs(tracks: MusicItemCollection<Track>?) -> MusicItemCollection<Song>{
        var songs = MusicItemCollection<Song>()
        if let tracks = tracks {
            tracks.forEach { track in
                switch track{
                case .song(let songInTrack):
                    songs += [songInTrack]
                default:
                    break
                }
            }
        }
        return songs
    }
}


