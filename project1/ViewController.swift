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
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCard(on: sender)
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    func flipCard(on card: UIButton) {
        let cardIndex = cardButtons.firstIndex(of: card)!
        if !game.cards[cardIndex].isMatched {
            if !game.cards[cardIndex].isFaceUp {
                game.chooseCard(at: cardIndex)
                updateViewFromModel()
            }
        }
    }
    
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
    
    private var emojiList = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
    
    private var emojiDict = [Int: String]()
    
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
