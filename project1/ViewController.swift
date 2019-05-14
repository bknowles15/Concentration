//
//  ViewController.swift
//  project1
//
//  Created by Bronson Knowles on 5/10/19.
//  Copyright © 2019 Bronson Knowles. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setNewTheme()
    }
    
    /// Sets a new theme for the Concentration game.
    private func setNewTheme() {
        // Select a new theme
        var themeIndex: Int
        if let previousThemeIndex = lastThemeIndex {
            repeat {
                themeIndex = emojiThemes.count.arc4random
            } while themeIndex == previousThemeIndex
        }
        else {
            themeIndex = emojiThemes.count.arc4random
        }
        lastThemeIndex = themeIndex
        
        // Set the new theme
        emojiList = emojiThemes[themeIndex]
        let backgroundColor = themeColors[themeIndex]["background"]
        cardColor = themeColors[themeIndex]["cards"]!
        self.view.backgroundColor = backgroundColor
        flipCountLabel.textColor = cardColor
        gameScoreLabel.textColor = cardColor
        newGameButton.setTitleColor(cardColor, for: UIControl.State.normal)
        for index in cardButtons.indices {
            cardButtons[index].backgroundColor = cardColor
        }
    }
    
    lazy private var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var gameScoreLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    /// Flips over card `sender` when user touches that card.
    @IBAction func touchCard(_ sender: UIButton) {
        flipCard(on: sender)
    }
    
    /// Creates a new game when the user touches `newGameButton`
    @IBAction func touchNewGameButton(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        setNewTheme()
        updateViewFromModel()
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
        gameScoreLabel.text = "Score: \(game.gameScore)"
        for index in cardButtons.indices {
            if game.cards[index].isFaceUp {
                cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cardButtons[index].setTitle(emoji(forCardID: game.cards[index].identifier), for: UIControl.State.normal)
            }
            else {
                cardButtons[index].setTitle("", for: UIControl.State.normal)
                cardButtons[index].backgroundColor = game.cards[index].isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : cardColor
            }
        }
        
        // When all cards matched, display win message
        if game.isFinished {
            showWinMessage()
        }
    }
    
    /// Displays a win message when the user has macthed all pairs of cards.
    private func showWinMessage() {
        for index in cardButtons.indices {
            cardButtons[index].setTitle("", for: UIControl.State.normal)
            cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
        }
        flipCountLabel.textColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
        gameScoreLabel.text = "You win!"
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
                               ["background": #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), "cards": #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)],
                               ["background": #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), "cards": #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)],
                               ["background": #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), "cards": #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)],
                               ["background": #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), "cards": #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)],
                               ["background": #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), "cards": #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)]]
    
    /// Stores the index of the theme used in the last game.
    /// Used to ensure the same theme is not picked for any two consecutive games.
    private var lastThemeIndex: Int?
    
    /// Stores the color of the cards (and text).
    private var cardColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    
    /// Stores current list of emojis for selected theme.
    /// An emoji is removed from this list when it is picked in-game.
    private var emojiList = [String]()
    
    /// Contains the mapping from card identifiers to corresponding emojis.
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
    /// Returns a uniform random number between 0 and `self`, exclusive.
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
