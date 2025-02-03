//
//  DJ.swift
//  Sprint1
//
//  Created by Rodrigo on 02-02-25.
//

import Foundation

// MARK: - DJ Styles Enum
enum DJStyle: String, CaseIterable {
    case chillVibes = "DJ Chill Vibes"
    case partyStarter = "DJ Party Starter"
    case rockAnthems = "DJ Rock Anthems"
    case emotionalTrip = "DJ Emotional Trip"
    case energyBoost = "DJ Energy Boost"
    case eightiesLovers = "DJ 80's Lovers"
}

// MARK: - DJ
struct DJ {
    
    let name: String
    var selectedStyles: [DJStyle]
    
    private var styleTags: [DJStyle: [String]] = [
        .chillVibes: ["chill", "soulful", "acoustic", "memories", "soft rock", "nostalgic", "peace"],
        .partyStarter: ["party", "dance", "energetic", "disco", "summer", "fun", "uplifting", "catchy"],
        .rockAnthems: ["rock", "hard rock", "power ballad", "anthem", "epic", "alternative", "angry"],
        .emotionalTrip: ["emotional", "heartbreak", "melancholic", "regret", "nostalgia", "reflective", "romantic"],
        .energyBoost: ["motivational", "inspiration", "freedom", "empowerment", "upbeat", "heroic", "power"],
        .eightiesLovers: ["80s", "synthwave", "pop", "iconic", "retro"]
    ]
    
    init(name: String, selectedStyles: [DJStyle]) {
        self.name = name
        self.selectedStyles = selectedStyles
    }
    
    func getUniqueTags() -> Set<String> {
        var uniqueTags = Set<String>()
        
        for style in selectedStyles {
            if let tags = styleTags[style] {
                uniqueTags.formUnion(tags)
            }
        }
        
        return uniqueTags
    }
    
    func filterSongs(fromSongs songs: [Song]) -> [Song] {
        let tags = getUniqueTags()
        
        return songs.filter { song in
            let songTags = Set(song.metadata.tags)
            return !songTags.isDisjoint(with: tags)
        }
    }
}
