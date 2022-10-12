//
//  MusicPlaylist.swift
//  MusicDiscovery
//
//  Created by 舘岡龍之介 on 2022/09/23.
//

import MusicKit
import Foundation
import MediaPlayer

struct MusicPlaylist: Identifiable, Hashable {
    var id: String
    let name: String
    let artwork: Artwork?
    let lastPlayedDate: Date?
    let musicTracks: MusicItemCollection<Song>?
}

