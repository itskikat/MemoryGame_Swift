//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Francisca Barros on 02/07/2020.
//  Copyright © 2020 Francisca Barros. All rights reserved.
//

import SwiftUI

// ViewModel - shared
class EmojiMemoryGame {
    // Class can access/modify
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    // Static - set on the type
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻", "🎃", "🕷"]
        return MemoryGame<String>(numberOfPairsOfCards: 3) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    // acess the outside world
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
    
    
}

