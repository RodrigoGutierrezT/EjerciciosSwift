//
//  GameChoice.swift
//  PiedraPapelTijerasStruct
//
//  Created by Rodrigo on 25-01-25.
//

import Foundation

enum GameChoice: String, CaseIterable {
    case rock = "1"
    case paper = "2"
    case scissors = "3"
    case exit = "4"
    
    var emoji: String {
        switch self {
        case .rock: return "👊"
        case .paper: return "🤚"
        case .scissors: return "✂️"
        case .exit: return ""
        }
    }
}
