//
//  Cardify.swift
//  Memorize
//
//  Created by Francisca Barros on 07/07/2020.
//  Copyright © 2020 Francisca Barros. All rights reserved.
//

import SwiftUI

// AnimatableModifier is a ViewModifier that is animatable (with our var)
struct Cardify: AnimatableModifier {
    var rotation: Double // amount of ratation in degrees
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp: Bool { // always tracking the rotation!
        rotation < 90
    }
    
    var animatableData: Double { // animates the rotation of our view!
        get { return rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View { // Content is a dont care we get from the protocol
        // create the modified View
        ZStack{
            Group {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white) // Fills with white, no matter the theme
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)  // Radius in points (=fonts) 'cornerRadius'-norm
                content // the ZStack the modifier is being sent to
            }
                .opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill() // Back of the card
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
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
