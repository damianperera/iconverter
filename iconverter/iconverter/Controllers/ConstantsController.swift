//
//  ConstantsController.swift
//  iconverter
//
//  Created by Damian Perera on 3/23/18.
//  Copyright © 2018 Damian Perera. All rights reserved.
//

import Foundation
import UIKit

class ConstantsController: UIViewController {
    
    var segueFromController:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func cancelSegue(_ sender: UIBarButtonItem) {
        switch segueFromController {
        case "weight":
            self.performSegue(withIdentifier: "segueConstantsBackToWeightController", sender: nil)
        case "temperature":
            self.performSegue(withIdentifier: "segueConstantsBackToTemperatureController", sender: nil)
        case "distance":
            self.performSegue(withIdentifier: "segueConstantsBackToDistanceController", sender: nil)
        case "liquids":
            self.performSegue(withIdentifier: "segueConstantsBackToLiquidsController", sender: nil)
        case "volume":
            self.performSegue(withIdentifier: "segueConstantsBackToVolumeController", sender: nil)
        case "speed":
            self.performSegue(withIdentifier: "segueConstantsBackToSpeedController", sender: nil)
        default:
            break
        }
    }
    
}
