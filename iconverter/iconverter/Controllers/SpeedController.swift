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
        txtMetres.delegate = self
        txtMiles.delegate = self
        txtKilometres.delegate = self
    }
    
    /**
        Action Components
    **/
    
    @IBAction func txtMetresOnEdit(_ sender: UITextField) {
        convert(from: .m_s, source: sender)
    }
    
    @IBAction func txtKilometresOnEdit(_ sender: UITextField) {
        convert(from: .km_h, source: sender)
    }
    
    @IBAction func txtMilesOnEdit(_ sender: UITextField) {
        convert(from: .ml_h, source: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        didSegue = true
        if let target = segue.destination.title {
            switch target {
            case "History":
                let destination = segue.destination as! HistoryController
                destination.segueFromController = "speed"
            case "Constants":
                let destination = segue.destination as! ConstantsController
                destination.segueFromController = "speed"
            default:
                break
            }
        }
    }
    
    @IBAction func backToSpeedController(storyboard: UIStoryboardSegue){
        
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
            case .km_h:
                if !(txtKilometres.tag == sourceTag) {
                    txtKilometres.text = result
                }
            case .ml_h:
                if !(txtMiles.tag == sourceTag) {
                    txtMiles.text = result
                }
            case .m_s:
                if !(txtMetres.tag == sourceTag) {
                    txtMetres.text = result
                }
            default:
                break
            }
        }
    }
    
    /**
        UI Components
    **/
    
    override func viewDidAppear(_ animated: Bool) {
        txtMetres.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if didSegue {
            txtMetres.becomeFirstResponder()
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
    }
    
}
