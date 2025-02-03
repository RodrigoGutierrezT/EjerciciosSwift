//
//  Playlist.swift
//  Sprint1
//
//  Created by Rodrigo on 02-02-25.
//

// MARK: - Playlist
struct Playlist {
    let name: String
    private(set) var songs: [Song] = []
    
    mutating func addSong(_ song: Song) {
        songs.append(song)
    }
    
    mutating func addSongs(_ newSongs: [Song]) {
        songs.append(contentsOf: newSongs)
    }
    
    mutating func removeSong(_ song: Song) {
        if let index = songs.firstIndex(of: song) {
            songs.remove(at: index)
        }
    }
    
    mutating func removeSongs(_ songsToRemove: [Song]) {
        songs.removeAll { song in
            songsToRemove.contains(song)
        }
    }
    
    func totalSongs() -> Int {
        return songs.count
    }
    
    mutating func clear() {
        songs.removeAll()
    }
    
    mutating func shuffle() {
        songs.shuffle()
    }
    
    mutating func reverse() {
        songs.reverse()
    }
    
    mutating func sortByOrder(_ order: SongOrder) {
        switch order {
        case .defaultOrder:
            break
        case .random:
            shuffle()
        case .reverse:
            reverse()
        case .byReleaseDate:
            sortByReleaseDate()
        case .byPopularityAscending:
            sortByPopularity(ascending: true)
        case .byPopularityDescending:
            sortByPopularity(ascending: false)
        case .byBPMDescending:
            sortByBPM(ascending: false)
        case .byBPMAscending:
            sortByBPM(ascending: true)
        }
    }
    
    
    mutating func sortByReleaseDate() {
        songs.sort {
            guard let date1 = $0.basicInfo.releaseDateAsDate else { return false }
            guard let date2 = $1.basicInfo.releaseDateAsDate else { return true }
            return date1 > date2
        }
    }
    
    mutating func sortByPopularity(ascending: Bool) {
        songs.sort {
            if ascending {
                return $0.metadata.popularity < $1.metadata.popularity
            } else {
                return $0.metadata.popularity > $1.metadata.popularity
            }
        }
    }
    
    mutating func sortByBPM(ascending: Bool) {
        songs.sort {
            if ascending {
                return $0.technicalInfo.bpm < $1.technicalInfo.bpm
            } else {
                return $0.technicalInfo.bpm > $1.technicalInfo.bpm
            }
        }
    }
}


