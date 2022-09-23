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
            LibraryBasedDiscovery()
            if modelData.isSelected {
                PlaybackBar()
                    .environmentObject(modelData)
                    .zIndex(2.0)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
