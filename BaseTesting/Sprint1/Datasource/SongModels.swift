//
//  Songs.swift
//  Sprint1
//
//  Created by Ismael Sabri Pérez on 16/1/25.
//

import Foundation

// MARK: - SongResponse
/// Modelo para el JSON con la lista de canciones (1 nivel)
struct SongsResponse: Codable {
    let songs: [Song]
}

// MARK: Modelo para el JSON de cada una de las canciones (2 nivel)
struct Song: Codable, Hashable {
    
    static func == (lhs: Song, rhs: Song) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: String
    let basicInfo: BasicInfo
    let technicalInfo: TechnicalInfo
    let metadata: Metadata
}

// MARK: - BasicInfo
/// Información básica de cada canción (3 nivel)
struct BasicInfo: Codable, Hashable {
    
    static func == (lhs: BasicInfo, rhs: BasicInfo) -> Bool {
        lhs.title == rhs.title &&
        lhs.album == rhs.album
    }
    
    let title: String
    let artist: String
    let durationMs: Int
    let genre: String
    let album: String
    let releaseDate: String
    let isExplicit: Bool
    
    // Mapeo de claves para coincidir con el JSON
    enum CodingKeys: String, CodingKey {
        case title
        case artist
        case durationMs = "duration_ms"
        case genre
        case album
        case releaseDate
        case isExplicit
    }
}

// extension para poder manipular release date como un objeto date en vez de string
extension BasicInfo {
    var releaseDateAsDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: releaseDate)
    }
}

// MARK: - TechnicalInfo
/// Información técnica de cada canción (3 nivel)
struct TechnicalInfo: Codable, Hashable {
    
    static func == (lhs: TechnicalInfo, rhs: TechnicalInfo) -> Bool {
        lhs.bpm == rhs.bpm &&
        lhs.key == rhs.key &&
        lhs.isrc == rhs.isrc
    }
    
    let bpm: Int
    let key: String
    let isrc: String
}

// MARK: - Metadata
/// Metadatos de cada canción (3 nivel)
struct Metadata: Codable, Hashable {
    
    static func == (lhs: Metadata, rhs: Metadata) -> Bool {
        lhs.tags == rhs.tags &&
        lhs.language == rhs.language &&
        lhs.popularity == rhs.popularity
    }
    
    let tags: [String]
    let language: String
    let popularity: Int
}
