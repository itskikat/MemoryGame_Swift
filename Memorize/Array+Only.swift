//
//  Array+Only.swift
//  Memorize
//
//  Created by Francisca Barros on 04/07/2020.
//  Copyright © 2020 Francisca Barros. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
