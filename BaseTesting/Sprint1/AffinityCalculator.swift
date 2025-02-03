//
//  AffinityCalculator.swift
//  Sprint1
//
//  Created by Rodrigo on 03-02-25.
//

protocol AffinityCalculatorDelegate {
    func calculateAffinityBetween(song1: Song, song2: Song) -> Double
    func calculateGenreAffinity(song1: Song, song2: Song) -> Double
    func calculateBPMAffinity(song1: Song, song2: Song) -> Double
    func calculateTagsAffinity(song1: Song, song2: Song) -> Double
    func calculateKeyAffinity(song1: Song, song2: Song) -> Double
    func calculatePopularityAffinity(song1: Song, song2: Song) -> Double
}

class AffinityCalculator: AffinityCalculatorDelegate {
    
    func calculateGenreAffinity(song1: Song, song2: Song) -> Double {
        let genreRelationships: [String: [String]] = [
            "Pop": ["Dance-Pop", "Pop-Rock", "Indie-Pop", "Electropop"],
            "Dance-Pop": ["Pop", "Electropop", "Disco"],
            "Pop-Rock": ["Pop", "Rock", "Indie-Pop"],
            "Electropop": ["Pop", "Dance-Pop", "Industrial Rock"],
            "Indie-Pop": ["Pop", "Pop-Rock", "Indie"],
            "Britpop": ["Pop", "Rock", "Indie"],
            "Rock": ["Pop-Rock", "Indie Rock", "Alternative Rock"],
            "Indie Rock": ["Rock", "Alternative Rock", "Indie"],
            "Alternative Rock": ["Rock", "Indie Rock", "Industrial Rock"],
            "Industrial Rock": ["Alternative Rock", "Electropop"],
            "Indie": ["Indie Rock", "Indie-Pop", "Britpop"],
            "R&B": ["Soul", "Hip-Hop"],
            "Soul": ["R&B", "Disco"],
            "Hip-Hop": ["R&B", "Dance-Pop"],
            "Disco": ["Dance-Pop", "Soul"],
            "Soundtrack": ["Orchestral", "Pop", "Rock"]
        ]

        let genre1 = song1.basicInfo.genre
        let genre2 = song2.basicInfo.genre

        if genre1 == genre2 {
            return 25
        }

        if let relatedGenres = genreRelationships[genre1], relatedGenres.contains(genre2) {
            return 17.5
        }

        for relatedGenre in genreRelationships[genre1] ?? [] {
            if let furtherRelatedGenres = genreRelationships[relatedGenre], furtherRelatedGenres.contains(genre2) {
                return 10
            }
        }

        return 0
    }
    
    func calculateBPMAffinity(song1: Song, song2: Song) -> Double {
        let bpm1 = song1.technicalInfo.bpm
        let bpm2 = song2.technicalInfo.bpm
        let bpmDifference = abs(bpm1 - bpm2)

        switch bpmDifference {
        case 0..<10:
            return 20
        case 10..<20:
            return 15
        case 20..<30:
            return 10
        case 30..<40:
            return 5
        default:
            return 0
        }
    }
    
    func calculateTagsAffinity(song1: Song, song2: Song) -> Double {
        let tags1 = Set(song1.metadata.tags)
        let tags2 = Set(song2.metadata.tags)

        let commonTags = tags1.intersection(tags2).count
        let maxTags = max(tags1.count, tags2.count)

        guard maxTags > 0 else { return 0 }

        let ratio = Double(commonTags) / Double(maxTags)
        return ratio * 30
    }
    
    func calculateKeyAffinity(song1: Song, song2: Song) -> Double {
        let key1 = song1.technicalInfo.key
        let key2 = song2.technicalInfo.key

        if key1 == key2 {
            return 15
        }

        let harmonicRelationships: [String: [String]] = [
            "C": ["G", "F", "Am"],
            "C#": ["G#", "F#", "A#m"],
            "Db": ["Ab", "Gb", "Bbm"],
            "D": ["A", "G", "Bm"],
            "D#": ["A#", "A", "Cm"],
            "Eb": ["Bb", "Ab", "Cm"],
            "E": ["B", "A", "C#m"],
            "F": ["C", "Bb", "Dm"],
            "F#": ["C#", "B", "D#m"],
            "Gb": ["Db", "B", "Ebm"],
            "G": ["D", "C", "Em"],
            "G#": ["D#", "D", "Fm"],
            "Ab": ["Eb", "Db", "Cm"],
            "A": ["E", "D", "F#m"],
            "A#": ["F", "E", "Gm"],
            "Bb": ["F", "Eb", "Gm"],
            "B": ["F#", "E", "G#m"]
        ]
        
        if let relatedKeys = harmonicRelationships[key1], relatedKeys.contains(key2) {
            return 10.5
        }

        return 0
    }
    
    func calculatePopularityAffinity(song1: Song, song2: Song) -> Double {
        let popularity1 = song1.metadata.popularity
        let popularity2 = song2.metadata.popularity

        let difference = abs(popularity1 - popularity2)
        let ratio = 1 - (Double(difference) / 100)

        return ratio * 10
    }

    func calculateAffinityBetween(song1: Song, song2: Song) -> Double {
        let genreAffinity = calculateGenreAffinity(song1: song1, song2: song2)
        let bpmAffinity = calculateBPMAffinity(song1: song1, song2: song2)
        let tagsAffinity = calculateTagsAffinity(song1: song1, song2: song2)
        let keyAffinity = calculateKeyAffinity(song1: song1, song2: song2)
        let popularityAffinity = calculatePopularityAffinity(song1: song1, song2: song2)

        return genreAffinity + bpmAffinity + tagsAffinity + keyAffinity + popularityAffinity
    }
}
