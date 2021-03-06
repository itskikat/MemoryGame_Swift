//
//  Grid.swift
//  Memorize
//
//  Created by Francisca Barros on 04/07/2020.
//  Copyright © 2020 Francisca Barros. All rights reserved.
//

import SwiftUI

// Takes two arguments - array of Identifiable + function
struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    private var items: [Item]                       // we dont care what that thing is
    private var viewForItem: (Item) -> ItemView     // neither that items view
    
    // Initializes our vars, so they can be private
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }

    // Has to bbe public
    var body: some View {
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    // Helper Funciontons
    private func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            self.body(for: item, in: layout)
        }
    }
    
    private func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)!
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height) // Same space of our space to each item
            .position(layout.location(ofItemAt: index))
    }
    
}
