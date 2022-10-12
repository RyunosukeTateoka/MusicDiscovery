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
            if let songs = playlist.musicTracks {
                createAlbumArtwork(musicItemDictionary: pickFourMusicItem(musicTracksInPlaylist: songs))
            }
            Text(playlist.name)
                .font(.callout)
                .bold()
        }
    }
    
    
    private func pickFourMusicItem(musicTracksInPlaylist: MusicItemCollection<Song>) -> [Int:Song] {
        var playlistMusicItemDictionary = [Int:Song]()
        var dictionaryCount = 1
        for musicItem in musicTracksInPlaylist {
            if playlistMusicItemDictionary.count < 4 {
                playlistMusicItemDictionary[dictionaryCount] = musicItem
                dictionaryCount += 1
            } else {
                break
            }
        }
        return playlistMusicItemDictionary
    }
    
    private func createAlbumArtwork(musicItemDictionary: [Int:Song]) -> some View {
        VStack {
            HStack {
                if let songLeftUpper = musicItemDictionary[1] {
                    getSongArtwork(song: songLeftUpper)
                }
                if let songRightUpper = musicItemDictionary[2] {
                    getSongArtwork(song: songRightUpper)
                }
            }
            HStack {
                if let songLeftBottom = musicItemDictionary[3] {
                    getSongArtwork(song: songLeftBottom)
                }
                if let songRightBottom = musicItemDictionary[4] {
                    getSongArtwork(song: songRightBottom)
                }
            }
        }
        .cornerRadius(4)
        .padding()
        .scaleEffect(x: 0.5, y: 0.5)
        .frame(width: 128, height: 128)
    }
    
    private func getSongArtwork(song: Song) -> some View {
        return AsyncImage(url: song.artwork?.url(width: 8, height: 8))
            .aspectRatio(contentMode: .fill)
    }
}
