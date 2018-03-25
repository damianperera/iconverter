//
//  LiquidsController.swift
//  iconverter
//
//  Created by Damian Perera on 3/23/18.
//  Copyright © 2018 Damian Perera. All rights reserved.
//

import UIKit

class LiquidsController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtGallon: UITextField!
    @IBOutlet weak var txtLitre: UITextField!
    @IBOutlet weak var txtPint: UITextField!
    @IBOutlet weak var txtFluidOunce: UITextField!
    
    var keyBoardHeight:CGFloat = 0
    var isKeyboardActive = false
    var tabBarOGHeight:CGFloat = 0
    var didSegue = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtGallon.delegate = self
        txtLitre.delegate = self
        txtPint.delegate = self
        txtFluidOunce.delegate = self
    }
    
    @IBAction func txtGallonOnEdit(_ sender: UITextField) {
    }
    
    @IBAction func txtLitreOnEdit(_ sender: UITextField) {
    }
    
    @IBAction func txtPintOnEdit(_ sender: UITextField) {
    }
    
    @IBAction func txtFluidOunceOnEdit(_ sender: UITextField) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
