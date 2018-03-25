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
    
    @IBOutlet weak var lblMagneticPermeability: UILabel!
    @IBOutlet weak var lblElectricPermittivity: UILabel!
    @IBOutlet weak var lblNeutronMass: UILabel!
    @IBOutlet weak var lblProtonMass: UILabel!
    @IBOutlet weak var lblElectronMass: UILabel!
    
    var segueFromController:String!
    let font:UIFont? = UIFont(name: "Helvetica", size:20)
    let fontSuper:UIFont? = UIFont(name: "Helvetica", size:12)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadElectronMass()
        loadProtonMass()
        loadNeutronMass()
        loadElectricPermittivity()
        loadMagneticPermeability()
    }
    
    func loadElectronMass() {
        let attString:NSMutableAttributedString = NSMutableAttributedString(string: "me = 9.109xxxxx x 10−31 (kg)", attributes: [.font:font!])
        attString.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:20,length:3))
        attString.setAttributes([.font:fontSuper!,.baselineOffset:-5], range: NSRange(location:1,length:2))
        lblElectronMass.attributedText = attString
    }
    
    func loadProtonMass() {
        let attString:NSMutableAttributedString = NSMutableAttributedString(string: "mp = 1.672xxxxx x 10−27 (kg)", attributes: [.font:font!])
        attString.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:20,length:3))
        attString.setAttributes([.font:fontSuper!,.baselineOffset:-5], range: NSRange(location:1,length:2))
        lblProtonMass.attributedText = attString
    }
    
    func loadNeutronMass() {
        let attString:NSMutableAttributedString = NSMutableAttributedString(string: "mn = 1.674xxxxx x 10−27 (kg)", attributes: [.font:font!])
        attString.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:20,length:3))
        attString.setAttributes([.font:fontSuper!,.baselineOffset:-5], range: NSRange(location:1,length:2))
        lblNeutronMass.attributedText = attString
    }
    
    func loadElectricPermittivity() {
        let attString:NSMutableAttributedString = NSMutableAttributedString(string: "ε0 = 8.854xxxxx x 10−12 C2/Nm2", attributes: [.font:font!])
        attString.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:29,length:1))
        attString.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:25,length:1))
        attString.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:20,length:3))

        attString.setAttributes([.font:fontSuper!,.baselineOffset:-5], range: NSRange(location:1,length:2))
        lblElectricPermittivity.attributedText = attString
    }
    
    func loadMagneticPermeability() {
        let attString:NSMutableAttributedString = NSMutableAttributedString(string: "μ0 = 4π x 10−7 Tm/A", attributes: [.font:font!])
        attString.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:12,length:2))
        attString.setAttributes([.font:fontSuper!,.baselineOffset:-5], range: NSRange(location:1,length:2))
        lblMagneticPermeability.attributedText = attString
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
    
    /**
        UI Components
    **/
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
