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
        NavigationView {
            VStack {
                Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        self.viewModel.choose(card: card)
                    } // initializes the variable
                    .padding(5)
                }
                Text("Score: \(viewModel.score)")
                    .font(Font.largeTitle)
                    .padding()
            }
            // MODIFIERS - applied to entire NavigationView
            .padding() // padds
            .foregroundColor(viewModel.theme.color) // Sets the environment to every view inside 
            .aspectRatio(2/3, contentMode: .fit)
            .navigationBarTitle(viewModel.theme.name)
            .navigationBarItems(trailing:
                Button("New Game", action: {
                    withAnimation(.easeInOut) {
                        self.viewModel.newGame()
                    }
                })
            )
        }
    }
}


struct CardView: View{
    var card: MemoryGame<String>.Card
    
    var body: some View{
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder // will be interpreted as a List of Views
    private func body(for size: CGSize) -> some View { // To avoid having to worry about the 'self.' error
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true)
                    .padding(5)
                    .opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
            }
            // .modifier(Cardify(isFaceUp: card.isFaceUp)) - used without the extension!
            .cardify(isFaceUp: card.isFaceUp)      // general ViewModifier built
        }
    }
    
    
    // MARK: - Drawing Constants
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
    
}

// used for the Canvas preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
