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
                    Spacer()
                    
                    AsyncImage(url: currentTrack.imageUrl)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 64, height: 64, alignment: .center)
                        .cornerRadius(4)
                        .padding()
                    
                    Spacer()
                    
                    PlayPauseButton()
                        .font(.system(size: 32))
                    .padding()
                    
                    Spacer()
                }
                .background(.gray)
            }
        }
    }
}
