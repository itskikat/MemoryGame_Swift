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
    private (set) var cards: Array<Card>        // Setting is private, reading is not
    var alreadySeenCards = Array<Card>()
    var score: Int = 0
    
    // Computed Variable
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            // New array, by filtering out
            cards.indices.filter { cards[$0].isFaceUp }.only // (Int) -> Bool
        }
        set {
            for index in cards.indices {
                if cards[index].isFaceUp {
                    alreadySeenCards.append(cards[index])
                }
                cards[index].isFaceUp = index == newValue // set every card to false unless its equal to what was set
            }
        }
    }
    
    // Function to choose a Card and flip it - mutating, since self is immutable by itself!
    mutating func choose(card: Card){
        print("card chosen: \(card)")
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isMatched {   // only exists if firstIndex!=nil
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard, potentialMatchIndex != chosenIndex {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    // Matched! Add 2 points
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                }
                else {
                    // Mismatch!
                    if (alreadySeenCards.firstIndex(matching: cards[chosenIndex]) != nil){
                        score -= 1
                    }
                    if (alreadySeenCards.firstIndex(matching: cards[potentialMatchIndex]) != nil){
                        score -= 1
                    }
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                // Zero or more than one facing up cards
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
        var isFaceUp: Bool = false {
            didSet { // whenever it changes
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent // dont care type
        var id: Int // to make the struct identifiable
        
        // MARK: - Bonus Time
        
        // this could give matching bonus points
        // if the user matches the card
        // before a certain amount of time passes during which the card is face up
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        // the last time this card was tuned face up (and is still face up)
        var lastFaceUpDate: Date?
        
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        // percentage of bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isCosumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isCosumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
        
    }
}
