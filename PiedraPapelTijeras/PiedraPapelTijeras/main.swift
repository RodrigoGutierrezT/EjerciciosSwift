//
//  main.swift
//  PiedraPapelTijeras
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
}

func readUserChoice() throws -> GameChoice {
    
    guard let userInput = readLine() else {
        throw GameError.invalidInput
    }
    guard let choice = GameChoice(rawValue: userInput.trimmingCharacters(in: .whitespacesAndNewlines)) else {
        throw GameError.invalidChoice
    }
    
    return choice
}

func generateComputerChoice() -> GameChoice {
    
    var computerChoice = GameChoice.allCases.randomElement()
    while computerChoice == GameChoice.exit {
        computerChoice = GameChoice.allCases.randomElement()
    }
    
    return computerChoice!
}

func evaluateMove(userChoice: GameChoice, computerChoice: GameChoice) -> String {
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

func choiceToEmoji(choice: GameChoice) -> String {
    switch choice {
    case .rock:
        return "👊"
    case .paper:
        return "🤚"
    case .scissors:
        return "✂️"
    case .exit:
        return ""
    }
}

func printMenu() {
    print("---- Rock, Paper, Scissors ----")
    print("Pick your Move (1, 2, 3 or 4):")
    print("1 - Rock")
    print("2 - Paper")
    print("3 - Scissors")
    print("4 - Exit")
    print()
    print(">", terminator: "")
}

func printResult(userChoice: GameChoice, computerChice: GameChoice, result: String) {
    print()
    print("Game on!")
    print("User choice:")
    print(choiceToEmoji(choice: userChoice))
    print("-----vs-----")
    print("Computer choice:")
    print(choiceToEmoji(choice: computerChice))
    print("---------")
    print()
    print("Result: \(result)!!")
}

func PlayAgainMenu() throws -> Bool {
    print()
    print("Play Again??? (Y,N)")
    print()
    print(">", terminator: "")
    
    guard let userInput = readLine() else {
        throw GameError.invalidInput
    }
    
    let cleanInput = userInput.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    
    if cleanInput != "y" && cleanInput != "n"{
        throw GameError.invalidChoice
    }

    return cleanInput == "y"
}

func gameLoop() {
    
    printMenu()

    do {
        let userChoice = try readUserChoice()
        
        if userChoice == .exit {
            print()
            print("Thanks for playing, comeback again!")
            return
        }
        
        let computerChoice = generateComputerChoice()
        let result = evaluateMove(userChoice: userChoice, computerChoice: computerChoice)
        printResult(userChoice: userChoice, computerChice: computerChoice, result: result)
        
    } catch GameError.invalidInput {
        print("Invalid input!")
        print("Valid values are: 1, 2, 3 or 4")
        print()
        gameLoop()
    } catch GameError.invalidChoice {
        print("Invalid choice!")
        print("Valid values are: 1, 2, 3 or 4")
        print()
        gameLoop()
    } catch {
        print("Unknow error 🥲")
        print("Please run the game again")
    }
    
    //MARK: play again section
    do {
        let playAgain = try PlayAgainMenu()
        
        if playAgain {
            gameLoop()
        } else {
            print()
            print("Thanks for playing!")
            return
        }
    } catch {
        print("Error getting the user choice")
        print("Shuting down...")
        return
    }
}

gameLoop()

