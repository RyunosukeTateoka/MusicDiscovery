//
//  MusicTracksList.swift
//  MusicDiscovery
//
//  Created by 舘岡龍之介 on 2022/07/23.
//

import MusicKit
import SwiftUI

struct MusicTrackList: View {
    @EnvironmentObject var modelData: ModelData
    @State var musicTracks = [MusicTrack]()
    @State private var searchQuery = ""
    
    var body: some View {
        let _ = print(Self._printChanges())
        
        NavigationView {
            List(modelData.musicTracks) { musicTrack in
                MusicTrackRow(musicTrack: musicTrack)
            }
            .navigationTitle("Search Music")
            .navigationBarTitleDisplayMode(.automatic)
            .searchable(text: $searchQuery)
            .onSubmit(of: .search) {
                modelData.searchMusicTracks(searchQuery: searchQuery)
            }
        }
    }
}

struct MusicTracksList_Previews: PreviewProvider {
    static var previews: some View {
        MusicTrackList()
    }
}
