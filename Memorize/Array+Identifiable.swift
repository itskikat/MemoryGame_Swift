//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Francisca Barros on 04/07/2020.
//  Copyright © 2020 Francisca Barros. All rights reserved.
//

import Foundation

// Only for Arrays where the Element is Identifiable
extension Array where Element: Identifiable {
    // To find the FirstIndex matching an Element in the Array
    func firstIndex(matching: Element) -> Int? {          // Int? == Optional<Int>!
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
