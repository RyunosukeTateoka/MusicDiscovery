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
    @State private var isShowingSheet = false
    
    var body: some View {
        NavigationView {
            if modelData.isSearching {
                MusicTrackList()
            } else {
                List {
                    Section(
                        header:
                            HStack{
                                Text("Recentry Listened Playlists").fontWeight(.bold)
                                Spacer()
                                Button("All Playlists") {
                                    self.isShowingSheet = true
                                }
                                .sheet(isPresented: self.$isShowingSheet) {
                                    AllPlaylists()
                                        .presentationDetents([.height(300)])
                                        .onAppear {
                                            modelData.playbackBarSpacerHeight = 45 / 100 * UIScreen.main.bounds.size.height
                                        }
                                        .onDisappear {
                                            modelData.playbackBarSpacerHeight = 7 / 100 * UIScreen.main.bounds.size.height
                                        }
                                }
                            }
                    ) {
                        ForEach(modelData.latestThreePlaylists) {
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
                .navigationTitle("Library")
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
