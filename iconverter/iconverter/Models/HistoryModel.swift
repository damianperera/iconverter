//
//  HistoryModel.swift
//  iconverter
//
//  Created by Damian Perera on 3/25/18.
//  Copyright © 2018 Damian Perera. All rights reserved.
//

import UIKit

class HistoryModel {
    
    func save(key: String, dict: Dictionary<Unit, String>) {
        let storableDictionary:Dictionary<String, String> = getStorableDictionary(dict: dict)
        var writableArray:Array<Dictionary<String, String>> = Array()
        if isAvailable(key: key) {
            writableArray = getStoredData(key: key)
            if (writableArray.count == 4) {
                writableArray.removeFirst()
                writableArray.append(storableDictionary)
            } else {
                writableArray.append(storableDictionary)
            }
            saveArray(arr: writableArray, key: key)
        } else {
            writableArray.append(storableDictionary)
            saveArray(arr: writableArray, key: key)
        }
    }
    
    func getHistory(unit: String) -> Array<Dictionary<Unit, String>>? {
        if isAvailable(key: unit) {
            let storedArray = getStoredData(key: unit)
            var returnArray:Array<Dictionary<Unit, String>> = Array()
            for result in storedArray {
                returnArray.append(getUsableDictionary(dict: result))
            }
            return returnArray
        }
        return nil
    }
    
    func getUsableDictionary(dict: Dictionary<String, String>) -> Dictionary<Unit, String> {
        var usableDictionary:Dictionary<Unit, String> = Dictionary()
        for (key, value) in dict {
            usableDictionary[ConverterModel().getUnit(name: key)] = value
        }
        return usableDictionary
    }
    
    func getStorableDictionary(dict: Dictionary<Unit, String>) -> Dictionary<String, String> {
        var storableDictionary:Dictionary<String, String> = Dictionary()
        for (key, value) in dict {
            storableDictionary[ConverterModel().getName(unit: key)] = value
        }
        return storableDictionary
    }
    
    func getStoredData(key: String) -> Array<Dictionary<String, String>> {
        return UserDefaults.standard.value(forKey: key) as! Array<Dictionary<String, String>>
    }
    
    func isAvailable(key: String) -> Bool {
        var isAvailable:Bool = false
        if UserDefaults.standard.value(forKey: key) as? Array<Dictionary<String, String>> != nil {
            isAvailable = true
        }
        return isAvailable
    }
    
    func saveArray(arr: Array<Dictionary<String, String>>, key: String) {
        UserDefaults.standard.set(arr, forKey: key)
    }
    
}
