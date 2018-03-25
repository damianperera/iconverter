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
    
    var segueFromController:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch segueFromController {
        case "weight":
            print(HistoryModel().getHistory(unit: "weight"))
        case "temperature":
            print(HistoryModel().getHistory(unit: "temperature"))
        case "distance":
            print(HistoryModel().getHistory(unit: "distance"))
        case "liquids":
            print(HistoryModel().getHistory(unit: "liquids"))
        case "volume":
            print(HistoryModel().getHistory(unit: "volume"))
        case "speed":
            print(HistoryModel().getHistory(unit: "speed"))
        default:
            break
        }
    }
    
    @IBAction func cancelSegue(_ sender: UIBarButtonItem) {
        switch segueFromController {
        case "weight":
            self.performSegue(withIdentifier: "segueHistoryBackToWeightController", sender: nil)
        case "temperature":
            self.performSegue(withIdentifier: "segueHistoryBackToTemperatureController", sender: nil)
        case "distance":
            self.performSegue(withIdentifier: "segueHistoryBackToDistanceController", sender: nil)
        case "liquids":
            self.performSegue(withIdentifier: "segueHistroyBackToLiquidsController", sender: nil)
        case "volume":
            self.performSegue(withIdentifier: "segueHistoryBackToVolumeController", sender: nil)
        case "speed":
            self.performSegue(withIdentifier: "segueHistoryBackToSpeedController", sender: nil)
        default:
            break
        }
    }
    
    /**
     UI Components
     **/
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
