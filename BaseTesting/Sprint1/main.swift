//
//  main.swift
//  Sprint1
//
//  Created by Ismael Sabri Pérez on 16/1/25.
//

import Foundation
import OSLog

Main().main() // Ejecutamos el programa

class Main {
    
    let logger = Logger(subsystem: "Sprint1", category: "main")

    // MARK: - Main
    func main() {
        let songs = SongsLoader().songs
        let djChill = DJ(name: "Chill Vibes DJ", selectedStyles: [.chillVibes])
        
        let chillVibesSongs = djChill.filterSongs(fromSongs: songs)

        var playlist = Playlist(name: "Chill Vibes Playlist")
        for song in chillVibesSongs {
            playlist.addSong(song)
        }
        
        var musicPlayer = MusicPlayer(playlist: playlist)
        
        let selectedOrder: SongOrder = .random
        
        // Sort the playlist according to the selected order
        playlist.sortByOrder(selectedOrder)
        
        musicPlayer.play(orderedBy: selectedOrder)
        
    }
    
    
}



