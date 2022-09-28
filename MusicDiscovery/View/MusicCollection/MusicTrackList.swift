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
    @Environment(\.isSearching) private var isSearching
    @State var musicTracks = [MusicTrack]()
    
    var body: some View {
        let _ = print(Self._printChanges())
        
        NavigationView {
            List(modelData.musicTracks) { musicTrack in
                MusicTrackRow(musicTrack: musicTrack)
            }
            .listStyle(InsetListStyle())
            .navigationTitle("Search Results")
        }
        .onChange(of: isSearching) { newValue in
            if !newValue {
                modelData.isSearching = false
            }
        }
    }
}

struct MusicTracksList_Previews: PreviewProvider {
    static var previews: some View {
        MusicTrackList()
    }
}
