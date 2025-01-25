//
//  Game.swift
//  PiedraPapelTijerasStruct
//
//  Created by Rodrigo on 25-01-25.
//

import Foundation

enum GameError: Error {
    case invalidInput
    case invalidChoice
}

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

struct Game {
    var userChoice: GameChoice
    var computerChoice: GameChoice
    
    func evaluate() -> String {
        if userChoice == computerChoice {
            return "Draw"
        }
        
        if userChoice == .rock && computerChoice == .scissors {
            return "User wins"
        }
        
        if userChoice == .paper && computerChoice == .rock {
            return "User wins"
        }
        
        if userChoice == .scissors && computerChoice == .paper {
            return "User wins"
        }
        
        return "Computer wins"
    }
    
    func printResult() {
        print()
        print("Game on!")
        print("User choice:")
        print(userChoice.emoji)
        print("-----vs-----")
        print("Computer choice:")
        print(computerChoice.emoji)
        print("---------")
        print()
        print("Result: \(evaluate())!!")
    }
}
