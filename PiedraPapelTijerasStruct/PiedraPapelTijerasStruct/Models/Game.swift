//
//  Game.swift
//  PiedraPapelTijerasStruct
//
//  Created by Rodrigo on 25-01-25.
//

import Foundation

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
