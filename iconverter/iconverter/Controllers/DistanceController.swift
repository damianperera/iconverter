//
//  DistanceController.swift
//  iconverter
//
//  Created by Damian Perera on 3/23/18.
//  Copyright © 2018 Damian Perera. All rights reserved.
//

import UIKit

class DistanceController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtYard: UITextField!
    @IBOutlet weak var txtCentimetre: UITextField!
    @IBOutlet weak var txtMillimetre: UITextField!
    @IBOutlet weak var txtInch: UITextField!
    @IBOutlet weak var txtMetre: UITextField!
    var keyBoardHeight:CGFloat = 0
    var isKeyboardActive = false
    var tabBarOGHeight:CGFloat = 0
    var didSegue = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCentimetre.delegate = self
        txtMillimetre.delegate = self
        txtInch.delegate = self
        txtMetre.delegate = self
        txtYard.delegate = self
    }
    
    /**
        Logical Components
    **/
    
    func convert(from: Unit, source: UITextField) {
        if let val:Double = Double(source.text!) {
            updateFields(results: ConverterModel().convert(unit: from, value: val), sourceTag: source.tag)
        }
    }
    
    func updateFields(results: Dictionary<Unit, Double>, sourceTag: Int) {
        for (unit, val) in results {
            let result:String = val.roundOff().toInt(unit: unit) != nil ? String(describing: val.roundOff().toInt(unit: unit)!) : String(val.roundOff())
            switch unit {
            case .m:
                if !(txtMetre.tag == sourceTag) {
                    txtMetre.text = result
                }
            case .ih:
                if !(txtInch.tag == sourceTag) {
                    txtInch.text = result
                }
            case .yd:
                if !(txtYard.tag == sourceTag) {
                    txtYard.text = result
                }
            case .cm:
                if !(txtCentimetre.tag == sourceTag) {
                    txtCentimetre.text = result
                }
            case .mm:
                if !(txtMillimetre.tag == sourceTag) {
                    txtMillimetre.text = result
                }
            default:
                break
            }
        }
    }
    
    /**
        Action Components
    **/
    
    @IBAction func txtCentimetreOnEdit(_ sender: UITextField) {
        convert(from: .cm, source: sender)
    }
    
    @IBAction func txtMetreOnEdit(_ sender: UITextField) {
        convert(from: .m, source: sender)
    }
    
    @IBAction func txtInchOnEdit(_ sender: UITextField) {
        convert(from: .ih, source: sender)
    }
    
    @IBAction func txtMillimetreOnEdit(_ sender: UITextField) {
        convert(from: .mm, source: sender)
    }
    
    @IBAction func txtYardOnEdit(_ sender: UITextField) {
        convert(from: .yd, source: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        didSegue = true
        if let target = segue.destination.title {
            switch target {
            case "History":
                let destination = segue.destination as! HistoryController
                destination.segueFromController = "distance"
            case "Constants":
                let destination = segue.destination as! ConstantsController
                destination.segueFromController = "distance"
            default:
                break
            }
        }
    }
    
    @IBAction func backToDistanceController(storyboard: UIStoryboardSegue){
        
    }
    
    /**
        UI Components
    **/
    
    override func viewDidAppear(_ animated: Bool) {
        txtCentimetre.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if didSegue {
            txtCentimetre.becomeFirstResponder()
            didSegue = false
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)),
                                               name: .UIKeyboardWillShow, object: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func keyboardWillAppear(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as?
            NSValue)?.cgRectValue {
            self.keyBoardHeight = keyboardSize.origin.y - keyboardSize.height -
                (self.tabBarController?.tabBar.frame.height)!
        }
        var tabBarFrame: CGRect = (self.tabBarController?.tabBar.frame)!
        tabBarFrame.origin.y = self.keyBoardHeight
        isKeyboardActive = true
        UIView.animate(withDuration: 0, animations: {() -> Void in
            self.tabBarController?.tabBar.frame = tabBarFrame
        })
    }
    
    @objc func keyboardWillDissapear() {
        var tabBarFrame: CGRect = CGRect(x: self.view.frame.minX, y: self.view.frame.maxY, width:
            self.view.frame.width, height: 30.0)
        tabBarFrame.origin.y = self.view.frame.maxY
        self.tabBarController?.tabBar.frame = tabBarFrame
        isKeyboardActive = false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }
        
        let newText = oldText.replacingCharacters(in: r, with: string)
        let isNumeric = newText.isEmpty || (Double(newText) != nil)
        let numberOfDots = newText.components(separatedBy: ".").count - 1
        
        let numberOfDecimalDigits: Int
        if let dotIndex = newText.index(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }
        
        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 4 && newText.count <= 9
    }
    
    override var disablesAutomaticKeyboardDismissal: Bool { return true }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
