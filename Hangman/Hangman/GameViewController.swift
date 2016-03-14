//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var incorrectGuessesLabel: UILabel!
    @IBOutlet weak var hangmanWordLabel: UILabel!
    @IBOutlet weak var hangmanImage: UIImageView!

    
    //actions
    var incorrect = [Character]()
    var word = String()
    var unchangedHangmanWord = String()
    var gameOver: Bool = false
    
    
    @IBAction func newGame(sender: AnyObject) {
        gameOver = false
        self.viewDidLoad()
    }
    @IBAction func restartGame(sender: AnyObject) {
        gameOver = false
        hangmanImage.image = UIImage(named: "hangman1.gif")
        self.incorrect = [Character]()
        hangmanWordLabel.text = unchangedHangmanWord
        incorrectGuessesLabel.text = "Incorrect Guesses:"
    }

    @IBAction func guessLetter(sender: UIButton) {
        guessActionButton(sender)
    }
    
    func guessActionButton(button: UIButton) {
        
        if (!gameOver) {
            let guessedLetter = button.titleLabel!.text
            let hangmanWord = hangmanWordLabel.text!
            var correct: Bool = false
            
            let guess: Character = guessedLetter!.characters[guessedLetter!.characters.startIndex]
            
            var newHangmanWord = ""
            for i in self.word.characters.indices {
                if self.word.characters[i] == guess {
                    correct = true
                    newHangmanWord = newHangmanWord + String(guess)
                }
                else {
                    newHangmanWord = newHangmanWord + String(hangmanWord.characters[i])
                }
            }
            hangmanWordLabel.text = newHangmanWord
            
            
            
            if(correct) {
                if (hangmanWordLabel.text! == self.word) {
                    gameWon()
                }
                
            } else {
                incorrectAction(button)
            }
        }
    }
    
   
    func gameWon() {
        gameOver = true
        let alertController = UIAlertController(
            title: "Game Over",
            message: "YOU WON!",
            preferredStyle: .Alert)
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
    
        alertController.addAction(cancelAction)
    
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func gameLost() {
        gameOver = true
        let alertController = UIAlertController(
            title: "Game Over",
            message: "YOU LOST!",
            preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)

    }
    
    func incorrectAction(button: UIButton) {
        var incorrectLabelText = incorrectGuessesLabel.text!
        let guessedLetter = button.titleLabel!.text
        let guess: Character = guessedLetter!.characters[guessedLetter!.characters.startIndex]
        if !self.incorrect.contains(guess) {
            incorrectLabelText = incorrectLabelText + " " + String(guess)
            self.incorrect.append(guess)
        }
        
        
        let s = "hangman" + String(incorrect.count+1) + ".gif"
        hangmanImage.image = UIImage(named: s)
        incorrectGuessesLabel.text = incorrectLabelText
        
        if (incorrect.count+1 >= 7) {
            gameLost()
        }
        
    }
    
    @IBAction func backButton(sender: AnyObject) {
         navigationController?.popViewControllerAnimated(true)
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        
        hangmanImage.image = UIImage(named: "hangman1.gif")
        var hangmanWord = ""
        self.word = ""
        self.incorrect = [Character]()
        for i in phrase.characters.indices {
            if phrase[i] == " " {
                hangmanWord = hangmanWord + "   "
                self.word = self.word + "   "
            }
            else {
                hangmanWord = hangmanWord + "_ "
                self.word = self.word + String(phrase[i]) + " "

            }
        }
        unchangedHangmanWord = hangmanWord
        hangmanWordLabel.text = hangmanWord
        incorrectGuessesLabel.text = "Incorrect Guesses:"

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
