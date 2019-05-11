//
//  Card.swift
//  project1
//
//  Created by Bronson Knowles on 5/10/19.
//  Copyright © 2019 Bronson Knowles. All rights reserved.
//

import Foundation

class Card {
    var isFaceUp: Bool
    var isMatched: Bool
    var identifier: Int

    static var currentIdentifier: Int = 0
    static func getNewIdentifier() -> Int {
        currentIdentifier += 1
        return currentIdentifier
    }
    
    init(identifier id: Int) {
        isFaceUp = false
        isMatched = false
        identifier = id
    }
}
