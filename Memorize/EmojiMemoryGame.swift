//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Francisca Barros on 02/07/2020.
//  Copyright © 2020 Francisca Barros. All rights reserved.
//

import SwiftUI

// ViewModel - shared
class EmojiMemoryGame: ObservableObject {
    // Class can access/modify
    @Published private var model: MemoryGame<String>
    
    var theme = Theme.themes.randomElement()! // Forces choosing a random theme
    
    init() {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    // Static - set on the type
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let emojis = theme.setOfEmoji.shuffled()
        let numberPairs = theme.numberOfPairs ?? Int.random(in: 2...emojis.count)
        return MemoryGame<String>(numberOfPairsOfCards: numberPairs) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    // MARK: - Intent(s)
    // acess the outside world
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
    
    func newGame() {
        theme = Theme.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    
}

