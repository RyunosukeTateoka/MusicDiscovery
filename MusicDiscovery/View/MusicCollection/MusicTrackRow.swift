//
//  MusicTracksRow.swift
//  MusicDiscovery
//
//  Created by 舘岡龍之介 on 2022/07/17.
//

import MusicKit
import SwiftUI
import MediaPlayer

struct MusicTrackRow: View {
    @EnvironmentObject var modelData: ModelData
    let musicTrack: MusicTrack
    
    var body: some View {
        HStack {
            AsyncImage(url: musicTrack.imageUrl)
                .frame(width: 80, height: 80, alignment: .center)
                .cornerRadius(8)
            VStack(alignment: .leading) {
                Text(musicTrack.name)
                    .font(.callout)
                    .bold()
                Spacer()
                Text(musicTrack.artist)
                    .font(.subheadline)
            }
            .padding()
        }
        .onTapGesture {
            print("*** Play Music ***")
            print("\(musicTrack)")
            modelData.currentTrack = musicTrack
            modelData.musicPlayer.setQueue(with: [musicTrack.id])
            print("*** Setted music track id ***")
            print("now playing item: \(modelData.musicPlayer.indexOfNowPlayingItem)")
            modelData.isSelected = true
            modelData.musicPlayer.play()
            modelData.isPlaying = true
        }
    }
}
