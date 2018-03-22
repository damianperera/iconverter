//
//  ExtensionsModel.swift
//  iconverter
//
//  Created by Damian Perera on 3/22/18.
//  Copyright © 2018 Damian Perera. All rights reserved.
//

import Foundation

extension Double {
    // If you don't want your code crash on each overflow, use this function that operates on optionals
    // E.g.: Int(Double(Int.max) + 1) will crash:
    // fatal error: floating point value can not be converted to Int because it is greater than Int.max
    func toInt(unit: Unit) -> Int? {
        if self > Double(Int.min) && self < Double(Int.max) && (floor(self) == self || unit == .st){
            return Int(self)
        } else {
            return nil
        }
    }
}
