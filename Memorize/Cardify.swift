//
//  Cardify.swift
//  Memorize
//
//  Created by Francisca Barros on 07/07/2020.
//  Copyright © 2020 Francisca Barros. All rights reserved.
//

import SwiftUI

// ViewModifier
struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View { // Content is a dont care we get from the protocol
        // create the modified View
        ZStack{
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white) // Fills with white, no matter the theme
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)  // Radius in points (=fonts) 'cornerRadius'-norm
                content // the ZStack the modifier is being sent to
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill() // Back of the card
            }
        }
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
}

// Can be called on any view
extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
