//
//  ContentView.swift
//  Memorize
//
//  Created by Francisca Barros on 02/07/2020.
//  Copyright © 2020 Francisca Barros. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame // pointer to our model
    
    var body: some View {
        return HStack() {
            // Not a LayoutView, like ZStack
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                } // initializes the variable
            }
        }
            // MODIFIERS
            .padding() // padds the entire HStack
            .foregroundColor(Color.orange) // Sets the environment to every view inside HStack
            .font(Font.largeTitle) // largest font - set to all texts in HStack
    }
}


struct CardView: View{
    var card: MemoryGame<String>.Card
    
    var body: some View{
        ZStack() {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.white) // Fills with white, no matter the theme
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(lineWidth: 3)  // Radius in points (=fonts) 'cornerRadius'-norm
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill() // Back of the card
        
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView(viewModel: EmojiMemoryGame())
    }
}
