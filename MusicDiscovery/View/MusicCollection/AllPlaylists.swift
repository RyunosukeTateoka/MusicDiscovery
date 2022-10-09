//
//  AllPlaylists.swift
//  MusicDiscovery
//
//  Created by 舘岡龍之介 on 2022/10/02.
//

import SwiftUI

struct AllPlaylists: View {
    @EnvironmentObject var modelData: ModelData
    @State var musicTracks = [MusicTrack]()
    @State private var searchQuery = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(
                    header:
                        HStack{
                            Text("All Playlists").fontWeight(.bold)
                            Spacer()
                        }
                ) {
                    ForEach(modelData.libraryPlaylists) {
                        playlist in
                        NavigationLink(
                            destination: PlaylistView(playlist: playlist),
                            label: {
                                PlaylistRow(playlist: playlist)
                            }
                        )
                    }
                }
            }
            .listStyle(InsetListStyle())
        }
    }
}
