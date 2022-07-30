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
    
    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    
    init() {
        fetchMusic()
    }

    private let request: MusicCatalogSearchRequest = {
        var request = MusicCatalogSearchRequest(term: "Louie Vega", types: [Song.self])
        request.limit = 25
        return request
    }()

    private func fetchMusic() {
        Task {
            let status = await MusicAuthorization.request()
            switch status {
            case .authorized:
                do {
                    let result = try await request.response()
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


