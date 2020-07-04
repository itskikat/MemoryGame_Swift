//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Francisca Barros on 02/07/2020.
//  Copyright © 2020 Francisca Barros. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame // pointer to our model
    // body is called by the system, everytime it wants to draw a View of the model
    var body: some View {
        return HStack() {
            // Not a LayoutView, like ZStack
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                } // initializes the variable
            }
        }
            // MODIFIERS - applied to entire HStack
            .padding() // padds
            .foregroundColor(Color.orange) // Sets the environment to every view inside HStack
            .aspectRatio(2/3, contentMode: .fit)
    }
}


struct CardView: View{
    var card: MemoryGame<String>.Card
    
    var body: some View{
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    // To avoid having to worry about the 'self.' error
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white) // Fills with white, no matter the theme
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)  // Radius in points (=fonts) 'cornerRadius'-norm
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill() // Back of the card
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
