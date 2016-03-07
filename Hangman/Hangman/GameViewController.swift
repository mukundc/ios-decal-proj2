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
    @IBOutlet weak var guessLabel: UITextField!
    @IBOutlet weak var hangmanWordLabel: UILabel!
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var correctButton: UIButton!
    @IBOutlet weak var incorrectButton: UIButton!
    
    //actions
    var incorrect = [Character]()
    var word = String()
    
    
    @IBAction func correctAction(sender: AnyObject) {
        let guessedLetter = guessLabel.text!
        let hangmanWord = hangmanWordLabel.text!
        
        let guess: Character = guessedLetter.characters[guessedLetter.characters.startIndex]
        var newHangmanWord = ""
        for i in self.word.characters.indices {
            if self.word.characters[i] == guess {
                print("we found a match")
                newHangmanWord = newHangmanWord + String(guess)
            }
            else {
                newHangmanWord = newHangmanWord + String(hangmanWord.characters[i])
            }
        }
        guessLabel.text = ""
        hangmanWordLabel.text = newHangmanWord
    }
    
    
    @IBAction func incorrectAction(sender: AnyObject) {
        var incorrectLabelText = incorrectGuessesLabel.text!
        let guessedLetter = guessLabel.text!
        let guess: Character = guessedLetter.characters[guessedLetter.characters.startIndex]
        if !self.incorrect.contains(guess) {
            incorrectLabelText = incorrectLabelText + " " + String(guess)
            self.incorrect.append(guess)
        }
        guessLabel.text = ""
        
        let s = "hangman" + String(incorrect.count) + ".gif"
        hangmanImage.image = UIImage(named: s)
        incorrectGuessesLabel.text = incorrectLabelText
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        
        hangmanImage.image = UIImage(named: "hangman1.gif")
        var hangmanWord = ""
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
