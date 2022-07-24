//
//  MusicTracksRow.swift
//  MusicDiscovery
//
//  Created by 舘岡龍之介 on 2022/07/17.
//

import MusicKit
import SwiftUI

struct MusicTracksRow: View {
    let musicTrack: MusicTrack
    
    var body: some View {
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
