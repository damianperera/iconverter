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
    
    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var lblSecond: UILabel!
    @IBOutlet weak var lblThird: UILabel!
    @IBOutlet weak var lblFourth: UILabel!
    @IBOutlet weak var lblFifth: UILabel!
    
    var segueFromController:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHistory()
    }
    
    func loadHistory() {
        switch segueFromController {
        case "weight":
            populateViews(arr: HistoryModel().getHistory(unit: "weight")!)
        case "temperature":
            populateViews(arr: HistoryModel().getHistory(unit: "temperature")!)
        case "distance":
            populateViews(arr: HistoryModel().getHistory(unit: "distance")!)
        case "liquids":
            populateViews(arr: HistoryModel().getHistory(unit: "liquids")!)
        case "volume":
            populateViews(arr: HistoryModel().getHistory(unit: "volume")!)
        case "speed":
            populateViews(arr: HistoryModel().getHistory(unit: "speed")!)
        default:
            break
        }
    }
    
    func populateViews(arr: Array<Dictionary<Unit, String>>) {
        print("Populating for ", arr.count, " results")
        var count:Int = 1
        for data in arr {
            if let label:UILabel = self.view.viewWithTag(count) as? UILabel {
                label.text = ""
                for (key, val) in data {
                    label.text = label.text?.appending(" " + val + " " + ConverterModel().getName(unit: key) + " =" )
                }
                let modifiedLabel = label.text!
                label.text = String(describing: modifiedLabel.dropLast())
            }
            count += 1
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
