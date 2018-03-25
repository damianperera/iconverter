//
//  SpeedController.swift
//  iconverter
//
//  Created by Damian Perera on 3/23/18.
//  Copyright © 2018 Damian Perera. All rights reserved.
//

import UIKit

class SpeedController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtMetres: UITextField!
    @IBOutlet weak var txtMiles: UITextField!
    @IBOutlet weak var txtKilometres: UITextField!
    
    var keyBoardHeight:CGFloat = 0
    var isKeyboardActive = false
    var tabBarOGHeight:CGFloat = 0
    var didSegue = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func txtMetresOnEdit(_ sender: UITextField) {
    }
    
    @IBAction func txtKilometresOnEdit(_ sender: UITextField) {
    }
    
    @IBAction func txtMilesOnEdit(_ sender: UITextField) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
