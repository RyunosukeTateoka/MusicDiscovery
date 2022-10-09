//
//  PlayPauseButton.swift
//  MusicDiscovery
//
//  Created by 舘岡龍之介 on 2022/07/24.
//

import SwiftUI

struct PlayPauseButton: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        Image(systemName: modelData.isPlaying ? "pause.fill" : "play.fill")
            .onTapGesture {
                if modelData.isPlaying == false {
                    Task {
                        do {
                            try await modelData.musicPlayer.play()
                            withAnimation(Animation.spring(response: 0.6, dampingFraction: 0.7)) {
                                modelData.isPlaying = true
                            }
                        } catch {
                            print("Failed to prepare music player to play.")
                        }
                    }
                } else {
                    modelData.musicPlayer.pause()
                    withAnimation(Animation.spring(response: 0.6, dampingFraction: 0.7)) {
                        modelData.isPlaying = false
                    }
                }
            }
    }
}

struct PlayPauseButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayPauseButton()
    }
}
