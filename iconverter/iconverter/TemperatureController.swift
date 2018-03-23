//
//  TemperatureController.swift
//  iconverter
//
//  Created by Damian Perera on 3/4/18.
//  Copyright © 2018 Damian Perera. All rights reserved.
//

import UIKit

class TemperatureController: UIViewController, UITabBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let target = segue.destination.title {
            switch target {
            case "History":
                let destination = segue.destination as! HistoryController
                destination.segueFromController = "temperature"
            case "Constants":
                let destination = segue.destination as! ConstantsController
                destination.segueFromController = "temperature"
            default:
                break
            }
        }
    }
    
    @IBAction func backToTemperatureController(storyboard: UIStoryboardSegue){
        
    }
    
}

