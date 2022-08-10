//
//  PlaybackBar.swift
//  MusicDiscovery
//
//  Created by 舘岡龍之介 on 2022/07/24.
//

import SwiftUI

struct PlaybackBar: View {
    @EnvironmentObject var modelData: ModelData
    @State private var downloadedData: Data? = nil
    @State private var uiImage: UIImage? = nil
    @State private var uiColor: UIColor? = nil
    @State private var backgroundColor: Color? = .gray

    
    var body: some View {
        let deviceScreenSize = UIScreen.main.bounds.size.width
        let artwork = AsyncImage(url: modelData.currentTrack?.imageUrl)
            .aspectRatio(contentMode: .fit)
            .frame(width: 64, height: 64, alignment: .center)
            .cornerRadius(4)
            .padding()
        let currentBackgroundColor = try? createBackgroundColor(modelData: modelData)
        
        VStack() {
            Spacer(minLength: 0)
            
            VStack() {
                ProgressSlider()
                    .padding(.horizontal)
                    .padding(.top)
                HStack {
                    Spacer()
                    
                    artwork
                    
                    Spacer()
                    
                    PlayPauseButton()
                        .font(.system(size: 32))
                    .padding()
                    
                    Spacer()
                }
            }
            .background(.ultraThinMaterial)
            .background(currentBackgroundColor?.opacity(0.48))
            .cornerRadius(8)
            .aspectRatio(2 / 3, contentMode: .fit)
            .frame(width: 9 / 10 * deviceScreenSize)
        }
    }
    
    private func downloadImageDataAsync(url: URL) {
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                downloadedData = data
                if let targetData = downloadedData {
                    uiImage = UIImage(data: targetData)
                }
                if let targetImage = uiImage {
                    uiColor = targetImage.createAverageColor == nil ? .gray : targetImage.createAverageColor
                }
                if let targetColor = uiColor {
                    backgroundColor = Color(uiColor: targetColor)
                }
            }
        }
    }
    
    private func createBackgroundColor(modelData: ModelData) throws -> Color {
        if let url = modelData.currentTrack?.imageUrl {
            downloadImageDataAsync(url: url)
        }
        if let currentBackgroundColor = backgroundColor {
            return currentBackgroundColor
        } else {
            return .gray
        }
    }
}
