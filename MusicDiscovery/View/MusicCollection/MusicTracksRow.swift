//
//  MusicTracksRow.swift
//  MusicDiscovery
//
//  Created by 舘岡龍之介 on 2022/07/17.
//

import MusicKit
import SwiftUI

struct MusicTracksRow: View {
    @State var musicTracks = [MusicTrack]()
    
    private let request: MusicCatalogSearchRequest = {
        var request = MusicCatalogSearchRequest(term: "Atjazz", types: [Song.self])
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
    
    var body: some View {
        let _ = print(Self._printChanges())
        
        NavigationView {
            List(musicTracks) { musicTrack in
                HStack {
                    AsyncImage(url: musicTrack.imageUrl)
                        .frame(width: 75, height: 75, alignment: .center)
                    VStack(alignment: .leading) {
                        Text(musicTrack.name)
                            .font(.title3)
                        Text(musicTrack.artist)
                            .font(.footnote)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            fetchMusic()
        }
    }
}

struct MusicTracksRow_Previews: PreviewProvider {
    static var previews: some View {
        MusicTracksRow()
    }
}
