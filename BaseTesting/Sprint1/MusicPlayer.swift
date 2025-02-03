//
//  MusicPlayer.swift
//  Sprint1
//
//  Created by Rodrigo on 02-02-25.
//
import Foundation

enum SongOrder {
    case defaultOrder
    case random
    case reverse
    case byReleaseDate
    case byPopularityAscending
    case byPopularityDescending
    case byBPMDescending
    case byBPMAscending
}

// MARK: - MusicPlayer
struct MusicPlayer {
    var playlist: Playlist
    var interval: Int
    var currentIndex: Int
    var affinityCalculator: AffinityCalculatorDelegate?
    
    mutating func play(orderedBy order: SongOrder) {
        playlist.sortByOrder(order)
        
        print("Now playing: \(playlist.name) with \(playlist.songs.count) songs.")
        
        for song in playlist.songs {
            playSong(song)
            currentIndex += 1
        }
    }
    
    func playSong(_ song: Song) {
        
        if currentIndex > 0 {
            let affinity = affinityCalculator?.calculateAffinityBetween(song1: playlist.songs[currentIndex - 1], song2: playlist.songs[currentIndex])
            if let affinity {
                print("The affinity between the previous song and the next one is \(String(format: "%.2f", affinity))%")
            }
        }
        
        print("Playing: \(song.basicInfo.title) by \(song.basicInfo.artist)")
        print()
        sleep(UInt32(interval))
    }
    
    func stop() {
        print("No more songs left in the playlist.")
    }
}

// init en extension para no perder el init implicito
extension MusicPlayer {
    init(playlist: Playlist, interval: Int = 5, affinityCalculator: AffinityCalculatorDelegate = AffinityCalculator()) {
        self.playlist = playlist
        self.interval = interval
        self.currentIndex = 0
        self.affinityCalculator = affinityCalculator
    }
}

