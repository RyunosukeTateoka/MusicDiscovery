//
//  PlaylistRow.swift
//  MusicDiscovery
//
//  Created by 舘岡龍之介 on 2022/09/23.
//

import SwiftUI
import MusicKit

struct PlaylistRow: View {
    var playlist: MusicPlaylist

    var body: some View {
        HStack {
            AsyncImage(url: playlist.imageUrl)
                .frame(width: 80, height: 80, alignment: .center)
                .cornerRadius(8)
            Text(playlist.name)
                .font(.callout)
                .bold()
            .padding()
        }
    }
}
