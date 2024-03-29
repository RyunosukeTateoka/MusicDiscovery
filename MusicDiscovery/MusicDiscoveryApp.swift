//
//  MusicDiscoveryApp.swift
//  MusicDiscovery
//
//  Created by 舘岡龍之介 on 2022/07/17.
//

import SwiftUI

@main
struct MusicDiscoveryApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
