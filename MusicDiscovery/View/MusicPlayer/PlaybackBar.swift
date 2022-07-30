//
//  PlaybackBar.swift
//  MusicDiscovery
//
//  Created by 舘岡龍之介 on 2022/07/24.
//

import SwiftUI

struct PlaybackBar: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        if let currentTrack = modelData.currentTrack {
            VStack {
                Spacer()
                
                HStack {
                    AsyncImage(url: currentTrack.imageUrl)
                        .frame(width: 80, height: 80, alignment: .center)
                        .cornerRadius(8)
                    PlayPauseButton()
                        .font(.system(size: 45))
                    .padding()
                }
                
            }
        }
    }
}
