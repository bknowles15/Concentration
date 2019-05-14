//
//  Card.swift
//  project1
//
//  Created by Bronson Knowles on 5/10/19.
//  Copyright © 2019 Bronson Knowles. All rights reserved.
//

import Foundation

/// A card in the Concentration game.
class Card {
    var isFaceUp: Bool
    var isMatched: Bool
    var identifier: Int

    static private(set) var currentIdentifier: Int = 0
    
    /// Returns a new identifier for a card, set by the programmer.
    static func getNewIdentifier() -> Int {
        currentIdentifier += 1
        return currentIdentifier
    }
    
    /// Initializes a card with identifier `id`.
    init(identifier id: Int) {
        isFaceUp = false
        isMatched = false
        identifier = id
    }
}
