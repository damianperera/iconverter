//
//  ConverterModel.swift
//  iconverter
//
//  Created by Damian Perera on 3/19/18.
//  Copyright © 2018 Damian Perera. All rights reserved.
//

import Foundation

enum Unit {
    case kg, g, oz, lbs, st, C, F, K, cm, m, ih, mm, yd, gal, l, pt, fl_oz, m3, cm3, l3, m_s, km_h, ml_h
}

class ConverterModel {
    
    let unitNames: [Unit: String] = [
        .kg: "kilograms",
        .g: "grams",
        .oz: "ounces",
        .lbs: "pounds",
        .st: "stone pounds",
        .C: "Celcius",
        .F: "Fahrenheit",
        .K: "Kelvin",
        .cm: "centimeters",
        .m: "meters",
        .ih: "inches",
        .mm: "millimeters",
        .yd: "yards",
        .gal: "gallons",
        .l: "litres",
        .pt: "pints",
        .fl_oz: "fluid ounces",
        .m3: "cubic meters",
        .cm3: "cubic centimeters",
        .l3: "litres",
        .m_s: "meters/sec",
        .km_h: "km/hour",
        .ml_h: "miles/hour"
    ]
    
    func getName(unit of: Unit) -> String {
        var result:String = unitNames[.kg]!
        for (val, name) in unitNames {
            if val == of {
                result = name
                break
            }
        }
        return result
    }
    
    func getUnit(name of: String) -> Unit {
        return (unitNames as NSDictionary).allKeys(for: of)[0] as! Unit
//        var result:Unit = .kg
//        for (val, name) in unitNames {
//            if name == of {
//                result = val
//                break
//            }
//        }
//        return result
    }
    
    func convert(unit from: Unit, value val: Double) -> Dictionary<Unit, Double> {
        
        var values: [Unit: Double] = [from: val]
        
        switch from {
        case .kg:
            values[.g] = val * 1000.0
            values[.oz] = val * 35.274
            values[.lbs] = val * 2.20462
            values[.st] = val * 0.157473
        case .g:
            values[.kg] = val * 0.001
            values[.oz] = val * 0.035274
            values[.lbs] = val * 0.00220462
            values[.st] = val * 0.000157473
        case .oz:
            values[.kg] = val * 0.0283495
            values[.g] = val * 28.3495
            values[.lbs] = val * 0.0625
            values[.st] = val * 0.00446429
        case .lbs:
            values[.kg] = val * 0.453592
            values[.g] = val * 453.592
            values[.oz] = val * 16
            values[.st] = val * 0.0714286
        case .st:
            values[.kg] = val * 6.35029
            values[.g] = val * 6350.29
            values[.oz] = val * 224
            values[.lbs] = val * 14
        case .C:
            values[.F] = val * 1.8 + 32
            values[.K] = val + 273.15
        case .F:
            values[.C] = (val - 32) / 1.8
            values[.K] = (val + 459.67) * 5/9
        case .K:
            values[.C] = val - 273.15
            values[.F] = val * 9/5 - 459.67
        case .cm:
            values[.m] = val * 0.01
            values[.ih] = val * 0.393701
            values[.mm] = val * 10
            values[.yd] = val * 0.0109361
        case .m:
            values[.cm] = val * 100
            values[.ih] = val * 39.3701
            values[.mm] = val * 1000
            values[.yd] = val * 1.09361
        case .ih:
            values[.cm] = val * 2.54
            values[.m] = val * 0.0254
            values[.mm] = val * 25.4
            values[.yd] = val * 0.0277778
        case .mm:
            values[.cm] = val * 0.1
            values[.m] = val * 0.001
            values[.ih] = val * 0.0393701
            values[.yd] = val * 0.00109361
        case .yd:
            values[.cm] = val * 91.44
            values[.m] = val * 0.9144
            values[.ih] = val * 36
            values[.mm] = val * 914.4
        case .gal:
            values[.l] = val * 3.78541
            values[.pt] = val * 8
            values[.fl_oz] = val * 128
        case .l:
            values[.gal] = val * 0.264172
            values[.pt] = val * 2.11338
            values[.fl_oz] = val * 33.814
        case .pt:
            values[.gal] = val * 0.125
            values[.l] = val * 0.473176
            values[.fl_oz] = val * 16
        case .fl_oz:
            values[.gal] = val * 0.0078125
            values[.l] = val * 0.0295735
            values[.pt] = val * 0.0625
        case .m3:
            values[.cm3] = val * 1000000
            values[.l3] = val * 1000
        case .cm3:
            values[.m3] = val * 1e-6
            values[.l3] = val * 0.001
        case .l3:
            values[.m3] = val * 0.001
            values[.cm3] = val * 1000
        case .m_s:
            values[.km_h] = val * 3.6
            values[.ml_h] = val * 2.23694
        case .km_h:
            values[.m_s] = val * 0.277778
            values[.ml_h] = val * 0.621371
        case .ml_h:
            values[.m_s] = val * 0.44704
            values[.km_h] = val * 1.60934
        }

        return values
    
    }
}
