//
//  ExtensionsModel.swift
//  iconverter
//
//  Created by Damian Perera on 3/22/18.
//  Copyright © 2018 Damian Perera. All rights reserved.
//

import Foundation

extension Double {
    
    func toInt(unit: Unit) -> Int? {
        if self > Double(Int.min) && self < Double(Int.max) && (floor(self) == self || unit == .st){
            return Int(self)
        } else {
            return nil
        }
    }
    
    func roundOff() -> Double {
        let divisor = pow(10.0, Double(4))
        return (self * divisor).rounded() / divisor
    }
    
}
