//
//  HangmanGame.swift
//  Hangman
//
//  Created by Ajuney Hora on 9/30/18.
//  Copyright © 2018 iOS DeCal. All rights reserved.
//

import Foundation

class HangmanGame {
    let phrase: String
    let hangmanPhrases = HangmanPhrases()
    var guesses: [Character]
    var incorrectGuesses: [Character]
    
    init() {
        self.phrase = hangmanPhrases.getRandomPhrase()
        self.guesses = Array(repeating: "_", count: strlen(phrase))
        self.incorrectGuesses = []
        
        // replace underscores w/ whitespace characters where neccessary
        for i in 0..<(strlen(self.phrase)) {
            let index = self.phrase.index(self.phrase.startIndex, offsetBy: i)
            if (self.phrase[index] == " ") {
                self.guesses[i] = " ";
            }
        }
    }
    
    func startNewGame() -> HangmanGame {
        return HangmanGame()
    }
    
    // returns true if the guess is in the phrase, else returns false
    func turn(currentGame: HangmanGame, guess: Character) -> Bool {
        if (Array(currentGame.phrase).contains(guess)) {
            for i in 0..<(strlen(currentGame.phrase)) {
                let index = currentGame.phrase.index(currentGame.phrase.startIndex, offsetBy: i)
                if (currentGame.phrase[index] == guess) {
                    currentGame.guesses[i] = guess
                }
            }
            return true
        } else {
            if (!currentGame.incorrectGuesses.contains(guess)) {
                currentGame.incorrectGuesses.append(guess)
            }
            return false
        }
    }
    
    // returns true if the player can continue to guess letters
    func isOver(currentGame: HangmanGame) -> Bool {
        if (!currentGame.guesses.contains("_") || currentGame.incorrectGuesses.count >= 6) {
            return true
        }
        return false
    }
    
    // returns true if the player won
    // called after isGameOver returns true
    func isWin(currentGame: HangmanGame) -> Bool {
        if (currentGame.incorrectGuesses.count >= 6) {
            return false
        }
        return true
    }
    
}
