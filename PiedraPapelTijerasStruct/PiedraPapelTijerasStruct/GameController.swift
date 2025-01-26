//
//  GameController.swift
//  PiedraPapelTijerasStruct
//
//  Created by Rodrigo on 25-01-25.
//

import Foundation

struct GameController {
    
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
    
    func playAgainMenu() throws -> Bool {
        print()
        print("Play Again??? (Y,N)")
        print()
        print(">", terminator: "")
        
        guard let userInput = readLine() else {
            throw GameError.invalidInput
        }
        
        let cleanInput = userInput.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        if cleanInput != "y" && cleanInput != "n" {
            throw GameError.invalidChoice
        }
        
        return cleanInput == "y"
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
        while computerChoice == .exit {
            computerChoice = GameChoice.allCases.randomElement()
        }
        return computerChoice!
    }
    
    func gameLoop() {
        var playing = true
        
        while playing {
            printMenu()

            do {
                let userChoice = try readUserChoice()
                
                if userChoice == .exit {
                    print()
                    print("Thanks for playing, come back again!")
                    playing = false
                    break
                }
                
                let computerChoice = generateComputerChoice()
                let game = Game(userChoice: userChoice, computerChoice: computerChoice)
                game.printResult()

            } catch GameError.invalidInput {
                print("Invalid input!")
                print("Valid values are: 1, 2, 3 or 4")
                print()
                continue
            } catch GameError.invalidChoice {
                print("Invalid choice!")
                print("Valid values are: 1, 2, 3 or 4")
                print()
                continue
            } catch {
                print("Unknown error 🥲")
                print("Please run the game again")
                playing = false
                break
            }

            do {
                let playAgain = try playAgainMenu()
                
                if playAgain {
                    continue
                } else {
                    print()
                    print("Thanks for playing!")
                    playing = false
                    break
                }
            } catch {
                print("Error getting the user choice")
                print("Shutting down...")
                playing = false
                break
            }
        }
    }

    
}

