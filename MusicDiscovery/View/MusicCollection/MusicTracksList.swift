//
//  MusicTracksList.swift
//  MusicDiscovery
//
//  Created by 舘岡龍之介 on 2022/07/23.
//

import MusicKit
import SwiftUI

struct MusicTracksList: View {
    @EnvironmentObject var modelData: ModelData
    @State var musicTracks = [MusicTrack]()
    
    var body: some View {
        let _ = print(Self._printChanges())
        
        NavigationView {
            List(modelData.musicTracks) { musicTrack in
                MusicTracksRow(musicTrack: musicTrack)
            }
        }
    }
}

struct MusicTracksList_Previews: PreviewProvider {
    static var previews: some View {
        MusicTracksList()
    }
}
