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
        let deviceScreenSize = UIScreen.main.bounds.size.width
        
        if let currentTrack = modelData.currentTrack {
            VStack() {
                Spacer(minLength: 0)
                
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
                .cornerRadius(8)
                .aspectRatio(2 / 3, contentMode: .fit)
                .frame(width: 9 / 10 * deviceScreenSize)
            }
        }
    }
}
