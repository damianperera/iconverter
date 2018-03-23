//
//  HistoryController.swift
//  iconverter
//
//  Created by Damian Perera on 3/23/18.
//  Copyright © 2018 Damian Perera. All rights reserved.
//

import Foundation
import UIKit

class HistoryController: UIViewController {
    
    var segueFromConroller:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelSegue(_ sender: UIBarButtonItem) {
        switch segueFromConroller {
        case "weight":
            self.performSegue(withIdentifier: "segueBackToWeightController", sender: nil)
        case "temperature":
            self.performSegue(withIdentifier: "segueBackToTemperatureController", sender: nil)
        default:
            break
        }
    }

}
