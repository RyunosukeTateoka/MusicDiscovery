//
//  LibraryBasedDiscovery.swift
//  MusicDiscovery
//
//  Created by 舘岡龍之介 on 2022/09/23.
//

import SwiftUI

struct LibraryBasedDiscovery: View {
    @EnvironmentObject var modelData: ModelData
    @State var musicTracks = [MusicTrack]()
    @State private var searchQuery = ""
    
    var body: some View {
        NavigationView {
            if modelData.isSearching {
                MusicTrackList()
            } else {
                List {
                    Section(
                        header:
                            HStack{
                                Text("Library Playlists").fontWeight(.bold)
                                Spacer()
                                Button(action: { print("Button Taped") }){
                                    Text("More...")
                                }
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
                .navigationTitle("Search for Discovery")
                .navigationBarTitleDisplayMode(.automatic)
            }
        }
        .searchable(text: $searchQuery)
        .onSubmit(of: .search) {
            modelData.isSearching = true
            modelData.searchMusicTracks(searchQuery: searchQuery)
        }
    }
}

struct LibraryBasedDiscovery_Previews: PreviewProvider {
    static var previews: some View {
        LibraryBasedDiscovery()
    }
}
