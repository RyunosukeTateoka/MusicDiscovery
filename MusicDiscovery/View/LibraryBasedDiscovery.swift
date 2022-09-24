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
                    Section(header: Text("Library Playlists").fontWeight(.bold)) {
                        ForEach(modelData.libraryPlaylists) { playlist in  PlaylistRow(playlist: playlist)
                        }
                    }
                }
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
