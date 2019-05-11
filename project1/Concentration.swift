//
//  Concentration.swift
//  project1
//
//  Created by Bronson Knowles on 5/10/19.
//  Copyright © 2019 Bronson Knowles. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    private(set) var numberOfPairsOfCards: Int
    var flipCount = 0
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
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
            for index in cards.indices {
                cards[index].isFaceUp = false
            }
            if newValue != nil {
                cards[newValue!].isFaceUp = true
            }
        }
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            flipCount += 1
            if let otherFaceUpCardIndex = indexOfOneAndOnlyFaceUpCard {
                cards[index].isFaceUp = true
                if cards[otherFaceUpCardIndex].identifier == cards[index].identifier {
                    cards[index].isMatched = true
                    cards[otherFaceUpCardIndex].isMatched = true
                }
            }
            else {
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        self.numberOfPairsOfCards = numberOfPairsOfCards
        for _ in 0..<numberOfPairsOfCards {
            let newIdentifier = Card.getNewIdentifier()
            cards.append(Card(identifier: newIdentifier))
            cards.append(Card(identifier: newIdentifier))
        }
    }
}
