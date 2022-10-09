//
//  ContentView.swift
//  MusicDiscovery
//
//  Created by 舘岡龍之介 on 2022/07/17.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        ZStack() {
            TabView {
                LibraryBasedDiscovery()
                    .tabItem {
                        Label("Library", systemImage: "music.note.list")
                    }
                DetectAndDiscoverSheet()
                    .tabItem {
                        Label("Detection", systemImage: "scope")
                    }
                History()
                    .tabItem {
                        Label("History", systemImage: "list.bullet")
                    }
            }
            if modelData.isSelected {
                VStack {
                    PlaybackBar()
                        .environmentObject(modelData)
                        .zIndex(3.0)
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                    Spacer().frame(height: modelData.playbackBarSpacerHeight)
                }                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
