//
//  MemoryGame.swift
//  Memorize
//
//  Created by Francisca Barros on 02/07/2020.
//  Copyright © 2020 Francisca Barros. All rights reserved.
//

import Foundation // Array, Dictionary, String, Int, Bool

// NON-UI , represents a Model
struct MemoryGame<CardContent> {
    // what does the model do?
    var cards: Array<Card>
    
    // Function to choose a Card and flip it - mutating, since self is immutable by itself!
    mutating func choose(card: Card){
        print("card chosen: \(card)")
        let chosenIndex: Int = self.index(of: card)
        self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp // changes the array directly
    }
    
    // Function to get the index of the card in our Cards Array
    func index(of card: Card) -> Int {
        // since card is Identifiable, we just need to look at the ID!
        for index in 0..<self.cards.count {
            if self.cards[index].id == card.id {
                return index
            }
        }
        return 0 // TODO: bogus!
    }

    // Only initializes all of our var
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()                                               // empty array of Cards
        for pairIndex in 0..<numberOfPairsOfCards {                            // not including numberOfPairsOfCards
            let content = cardContentFactory(pairIndex)                        // VIEWMODEL knows the type!
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    // Will represent a single Card - name = MemoryGame.Card
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent // dont care type
        var id: Int // to make the struct identifiable
        
    }
}
