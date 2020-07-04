//
//  MemoryGame.swift
//  Memorize
//
//  Created by Francisca Barros on 02/07/2020.
//  Copyright © 2020 Francisca Barros. All rights reserved.
//

import Foundation // Array, Dictionary, String, Int, Bool

// NON-UI , represents a Model
struct MemoryGame<CardContent> where CardContent: Equatable {
    // what does the model do?
    var cards: Array<Card>
    
    // Computed Variable
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            // New array, by filtering out
            cards.indices.filter { cards[$0].isFaceUp }.only // (Int) -> Bool
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue // set every card to false unless its equal to what was set
            }
        }
    }
    
    // Function to choose a Card and flip it - mutating, since self is immutable by itself!
    mutating func choose(card: Card){
        print("card chosen: \(card)")
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {   // only exists if firstIndex!=nil
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex // setting the value
            }
            
        }
    }

    // Only initializes all of our var
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()                                                  // empty array of Cards
        for pairIndex in 0..<numberOfPairsOfCards {                            // not including numberOfPairsOfCards
            let content = cardContentFactory(pairIndex)                        // VIEWMODEL knows the type!
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    // Will represent a single Card - name = MemoryGame.Card
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent // dont care type
        var id: Int // to make the struct identifiable
        
    }
}
