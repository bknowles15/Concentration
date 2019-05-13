//
//  ViewController.swift
//  project1
//
//  Created by Bronson Knowles on 5/10/19.
//  Copyright © 2019 Bronson Knowles. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy private var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    /// Flips over card `sender` when user touches that card.
    @IBAction func touchCard(_ sender: UIButton) {
        flipCard(on: sender)
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var gameScore: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    /// Creates a new game when the user touches `newGameButton`
    @IBAction func touchNewGameButton(_ sender: UIButton) {
    }
    
    
    /// Flips over card `card` when user touches that card (internal implementation).
    private func flipCard(on card: UIButton) {
        let cardIndex = cardButtons.firstIndex(of: card)!
        if !game.cards[cardIndex].isMatched {
            if !game.cards[cardIndex].isFaceUp {
                game.chooseCard(at: cardIndex)
                updateViewFromModel()
            }
        }
    }
    
    /// Updates the UI after a card is chosen.
    private func updateViewFromModel() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        for index in cardButtons.indices {
            if game.cards[index].isFaceUp {
                cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cardButtons[index].setTitle(emoji(forCardID: game.cards[index].identifier), for: UIControl.State.normal)
            }
            else {
                cardButtons[index].setTitle("", for: UIControl.State.normal)
                cardButtons[index].backgroundColor = game.cards[index].isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }

    /// Contains all emojis for all possible themes.
    private let emojiThemes = [["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "🧟‍♀️"],
                               ["⚽️", "🏀", "🏈", "⚾️", "🏐", "🎾", "⛳️", "🥊", "🏊‍♀️", "🚴‍♂️"],
                               ["🍍", "🍔", "🍕", "🌮", "🍣", "🥧", "🍺", "🍷", "☕️", "🌶"],
                               ["🏝", "🏜", "🌋", "🏔", "🏕", "💧", "🌪", "🔥", "⚡️", "☀️"],
                               ["🐶", "🐱", "🐭", "🐸", "🙈", "🐼", "🐨", "🦁", "🐮", "🐷"],
                               ["🇦🇺", "🇨🇦", "🇩🇪", "🇯🇵", "🇲🇽", "🇬🇧", "🇺🇸", "🇮🇳", "🇫🇷", "🇨🇳"]]
    
    /// Contains all color schemes for all possible themes.
    private let themeColors = [["background": #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), "cards": #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)],
                               ["background": #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), "cards": #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)],
                               ["background": #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), "cards": #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)],
                               ["background": #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), "cards": #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)],
                               ["background": #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), "cards": #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)],
                               ["background": #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), "cards": #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]]
    
    private var emojiList = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "🧟‍♀️"]
    
    private var emojiDict = [Int: String]()
    
    /// Returns the emoji for card with identifier `identifier`.
    private func emoji(forCardID identifier: Int) -> String {
        if emojiDict[identifier] != nil {
            return emojiDict[identifier]!
        }
        if emojiList.count > 0 {
            let randomNumber = emojiList.count.arc4random
            let resultEmoji = emojiList[randomNumber]
            emojiList.remove(at: randomNumber)
            emojiDict[identifier] = resultEmoji
            return resultEmoji
        }
        return "?"
    }
    
}

extension Int {
    /// Returns a random number between 0 and `self`, exclusive.
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        return 0
    }
}
