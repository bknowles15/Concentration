//
//  Concentration.swift
//  project1
//
//  Created by Bronson Knowles on 5/10/19.
//  Copyright © 2019 Bronson Knowles. All rights reserved.
//

import Foundation

/// A game of Concentration, including cards and logic to operate the game.
class Concentration {
    var cards = [Card]()
    private(set) var numberOfPairsOfCards: Int
    var flipCount = 0
    var gameScore = 0
    var seenCardIndices: Set<Int> = []
    var isFinished = false
    var numberOfMatchedPairs = 0
    
    /// The index of the only face up card when only one card is face up.
    /// If there are 0 or 2 face up cards, this is nil.
    // Time complexity: O(N), where N = number of cards
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            // Find the one and only face up card, if there is one
            var faceUpIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp, faceUpIndex == nil {
                    faceUpIndex = index
                }
                else if cards[index].isFaceUp {
                    return nil
                }
            }
            return faceUpIndex
        }
        set {
            // Mark all cards as face down except the one and only face up card
            for index in cards.indices {
                cards[index].isFaceUp = false
            }
            if newValue != nil {
                cards[newValue!].isFaceUp = true
            }
        }
    }
    
    /// Marks selected card as face up and determines if user has found match.
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            flipCount += 1
            // Another face up card exists
            if let otherFaceUpCardIndex = indexOfOneAndOnlyFaceUpCard {
                cards[index].isFaceUp = true
                // Cards match
                if cards[otherFaceUpCardIndex].identifier == cards[index].identifier {
                    cards[index].isMatched = true
                    cards[otherFaceUpCardIndex].isMatched = true
                    gameScore += 2
                    numberOfMatchedPairs += 1
                    if numberOfMatchedPairs == numberOfPairsOfCards {
                        isFinished = true
                    }
                }
                // Cards do not match
                else {
                    if seenCardIndices.contains(cards[index].identifier) {
                        gameScore -= 1
                    }
                    if seenCardIndices.contains(cards[otherFaceUpCardIndex].identifier) {
                        gameScore -= 1
                    }
                    seenCardIndices.insert(cards[index].identifier)
                    seenCardIndices.insert(cards[otherFaceUpCardIndex].identifier)
                }
            }
            // No other face up card exists
            else {
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    /// Initializes the Concetration game to have `numberOfPairsOfCards` cards.
    init(numberOfPairsOfCards: Int) {
        self.numberOfPairsOfCards = numberOfPairsOfCards
        
        for _ in 0..<numberOfPairsOfCards {
            let newIdentifier = Card.getNewIdentifier()
            cards.append(Card(identifier: newIdentifier))
            cards.append(Card(identifier: newIdentifier))
        }
        
        cards.shuffle()
    }
}
