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
    let musicTrack: Song
    
    var body: some View {
        HStack {
            AsyncImage(url: musicTrack.artwork?.url(width: 80, height: 80))
                .frame(width: 80, height: 80, alignment: .center)
                .cornerRadius(8)
            VStack(alignment: .leading) {
                Text(musicTrack.title)
                    .font(.callout)
                    .bold()
                Spacer()
                Text(musicTrack.artistName)
                    .font(.subheadline)
            }
            .padding()
        }
        .onTapGesture {
            print("*** Play Music ***")
            print("\(musicTrack)")
            modelData.currentTrack = musicTrack
            modelData.musicPlayer.queue = ApplicationMusicPlayer.Queue(for: [musicTrack])
            print("*** Setted music track id ***")
            modelData.isSelected = true
            Task {
                do {
                    try await modelData.musicPlayer.play()
                    modelData.isPlaying = true
                } catch {
                    print(String(describing: error))
                }
            }
        }
    }
}
