//
//  ProgressBar.swift
//  MusicDiscovery
//
//  Created by 舘岡龍之介 on 2022/08/04.
//

import SwiftUI
import CoreMedia

struct ProgressSlider: View {
    @EnvironmentObject var modelData: ModelData
    @State private var playingTime = 0.0
    @State private var isEditing = false
    @State private var timer = Timer.publish(every: 0.1, on: .current, in: .default).autoconnect()
    
    init() {
        UISlider.appearance().setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
    }

    var body: some View {
        if let currentMusicTrack = modelData.musicPlayer.nowPlayingItem {
            Slider (
                value: $playingTime,
                in: 0...currentMusicTrack.playbackDuration,
                onEditingChanged: {
                    editing in isEditing = editing;
                    modelData.musicPlayer.currentPlaybackTime = TimeInterval(playingTime);
                }
            )
            .accentColor(.white)
            .onReceive(timer) { (_) in updatePlayingTime()}
        }
    }
    
    private func updatePlayingTime() {
        self.playingTime = modelData.musicPlayer.currentPlaybackTime
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressSlider()
    }
}
