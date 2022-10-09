//
//  Playlists.swift
//  MusicDiscovery
//
//  Created by 舘岡龍之介 on 2022/09/24.
//

import SwiftUI
import MusicKit

struct PlaylistView: View {
    @EnvironmentObject var modelData: ModelData
    let playlist: MusicPlaylist
    @State var musicTracks = [MusicTrack]()
    
    var body: some View {
        NavigationView {
            List {
                if let musicTracks = playlist.musicTracks {
                    ForEach(musicTracks, id: \.id) {
                        musicTrack in
                        MusicTrackRow(musicTrack: musicTrack)
                    }
                }
            }
            .listStyle(InsetListStyle())
        }
        .navigationTitle(Text(playlist.name))
    }
}
