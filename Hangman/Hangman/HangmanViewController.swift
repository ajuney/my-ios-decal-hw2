//
//  HangmanViewController.swift
//  Hangman
//
//  Created by Ajuney Hora on 9/27/18.
//  Copyright © 2018 iOS DeCal. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {
    
    @IBOutlet weak var hangman: UIImageView!
    @IBOutlet weak var guesses: UILabel!
    @IBOutlet weak var incorrectGuesses: UILabel!
    var currentGame: HangmanGame!
    var image: Int = 1
    let alphabet: [Character] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currentGame = HangmanGame()
        hangman.image = #imageLiteral(resourceName: "hangman1")
        updateGuesses()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateImage(_ imageNumber: Int) {
        image += 1
        let imageName = "hangman" + String(image)
        hangman.image = UIImage(named: imageName)
    }
    
    func updateGuesses() {
        var string = ""
        for char in currentGame.guesses {
            string += String(char)
        }
        guesses.text = string
    }
    
    func updateIncorrectGuesses() {
        var string = ""
        for char in currentGame.incorrectGuesses {
            string += String(char)
        }
        incorrectGuesses.text = "Incorrect: " + string
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        currentGame = HangmanGame()
        image = 0
        updateImage(image)
        updateGuesses()
        updateIncorrectGuesses()
    }
    @IBAction func letterPressed(_ sender: UIButton) {
        let guessedLetter = alphabet[sender.tag]

        let repeatedGuess = currentGame.incorrectGuesses.contains(guessedLetter)
        let correctGuess = currentGame.turn(currentGame: currentGame, guess: guessedLetter)
        if (correctGuess && !repeatedGuess) {
            updateGuesses()
        } else {
            if (!repeatedGuess) {
                updateIncorrectGuesses()
                updateImage(image)
            }
        }
        
        if (currentGame.isOver(currentGame: currentGame)) {
            let win = currentGame.isWin(currentGame: currentGame)
            var result: String
            if (win) {
                result = "YOU WON!!!"
            } else {
                result = "YOU LOST"
            }
            let alertController = UIAlertController(title: "Game Over.", message: result, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction) in
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

