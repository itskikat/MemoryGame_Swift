//
//  EmojiMemoryGameTheme.swift
//  Memorize
//
//  Created by Francisca Barros on 05/07/2020.
//  Copyright © 2020 Francisca Barros. All rights reserved.
//

import SwiftUI

struct Theme {
    let name: String
    let setOfEmoji: [String]
    let numberOfPairs: Int?
    let color: Color
    
    static let themes: [Theme] = [
        Theme(
            name: "Cats",
            setOfEmoji: ["😺", "😸", "😹", "😻", "🙀", "😿", "😾", "😼"],
            numberOfPairs: 8,
            color: .yellow
        ),
        Theme(
            name: "Vegetables",
            setOfEmoji: ["🥦", "🍅", "🌶", "🌽", "🥕", "🥬", "🥒", "🍠", "🍆", "🧅"],
            numberOfPairs: nil,
            color: .green
        ),
        Theme(
            name: "Halloween",
            setOfEmoji: ["👻", "🎃", "🙀", "😈", "☠️", "💀", "🦇", "🍭", "🕸", "🕷"],
            numberOfPairs: nil,
            color: .orange
        ),
        Theme(
            name: "Flags",
            setOfEmoji: ["🇧🇷", "🇻🇬", "🇮🇹", "🇵🇹", "🇷🇺", "🇺🇸", "🇯🇵", "🇰🇷"],
            numberOfPairs: nil,
            color: .blue
        ),
        Theme(
            name: "Vehicles",
            setOfEmoji: ["🚗", "🚑", "🚜", "🛵", "🚓", "🚂", "🚀", "🚁"],
            numberOfPairs: nil,
            color: .red
        ),
        Theme(
            name: "Faces",
            setOfEmoji: ["😎", "🥳", "🤓", "🤯", "😇", "😳", "😰", "🤠"],
            numberOfPairs: nil,
            color: .yellow
        ),
    ]
}
