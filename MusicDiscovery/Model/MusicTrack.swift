//
//  MusicTrack.swift
//  MusicDiscovery
//
//  Created by 舘岡龍之介 on 2022/07/17.
//

import MusicKit
import Foundation
import MediaPlayer

struct MusicTrack: Identifiable, Hashable {
    var id: String
    let name: String
    let artist: String
    let imageUrl: URL?
}
