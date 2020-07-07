//
//  Pie.swift
//  Memorize
//
//  Created by Francisca Barros on 07/07/2020.
//  Copyright © 2020 Francisca Barros. All rights reserved.
//

import SwiftUI

// Background of our emoji
struct Pie: Shape {
    
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false // default
    
    func path(in rect: CGRect) -> Path { // rect - where we're supposed to fit our shape
        let center = CGPoint(x: rect.midX, y: rect.midY) // center of our rectagle
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radians)),
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )
        
        var p = Path()
        p.move(to: center)
        p.addLine(to: start) // Calculate start position of our pie
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise
        )
        p.addLine(to: center)
        
        return p
    }
}
