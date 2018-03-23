//
//  DistanceController.swift
//  iconverter
//
//  Created by Damian Perera on 3/23/18.
//  Copyright © 2018 Damian Perera. All rights reserved.
//

import UIKit

class DistanceController: UIViewController {
    
    @IBOutlet weak var txtCentimetre: UITextField!
    @IBOutlet weak var txtMillimetre: UITextField!
    @IBOutlet weak var txtYard: NSLayoutConstraint!
    @IBOutlet weak var txtInch: UITextField!
    @IBOutlet weak var txtMetre: UITextField!
    var keyBoardHeight:CGFloat = 0
    var isKeyboardActive = false
    var tabBarOGHeight:CGFloat = 0
    var didSegue = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /**
        Logical Components
    **/
    
    /**
        Action Components
    **/
    
    @IBAction func txtCentimetreOnEdit(_ sender: UITextField) {
    }
    
    @IBAction func txtMetreOnEdit(_ sender: UITextField) {
    }
    
    @IBAction func txtInchOnEdit(_ sender: UITextField) {
    }
    
    @IBAction func txtMillimetreOnEdit(_ sender: UITextField) {
    }
    
    @IBAction func txtYardOnEdit(_ sender: UITextField) {
    }
    
    
    /**
        UI Components
    **/
    
}
