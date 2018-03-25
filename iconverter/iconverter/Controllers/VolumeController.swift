//
//  VolumeController.swift
//  iconverter
//
//  Created by Damian Perera on 3/23/18.
//  Copyright © 2018 Damian Perera. All rights reserved.
//

import UIKit

class VolumeController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtLitres: UITextField!
    @IBOutlet weak var txtCubicCentimetres: UITextField!
    @IBOutlet weak var txtCubicMetres: UITextField!
    
    var keyBoardHeight:CGFloat = 0
    var isKeyboardActive = false
    var tabBarOGHeight:CGFloat = 0
    var didSegue = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtLitres.delegate = self
        txtCubicCentimetres.delegate = self
        txtCubicMetres.delegate = self
    }
    
    /**
        Action Components
     **/
    
    @IBAction func txtCubicMetresOnEdit(_ sender: UITextField) {
        convert(from: .m3, source: sender)
    }
    
    @IBAction func txtCubicCentimetresOnEdit(_ sender: UITextField) {
        convert(from: .cm3, source: sender)
    }
    
    @IBAction func txtLitresOnEdit(_ sender: UITextField) {
        convert(from: .l3, source: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        didSegue = true
        if let target = segue.destination.title {
            switch target {
            case "History":
                let destination = segue.destination as! HistoryController
                destination.segueFromController = "volume"
            case "Constants":
                let destination = segue.destination as! ConstantsController
                destination.segueFromController = "volume"
            default:
                break
            }
        }
    }
    
    @IBAction func backToVolumeController(storyboard: UIStoryboardSegue){
        
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
            case .cm3:
                if !(txtCubicCentimetres.tag == sourceTag) {
                    txtCubicCentimetres.text = result
                }
            case .m3:
                if !(txtCubicMetres.tag == sourceTag) {
                    txtCubicMetres.text = result
                }
            case .l3:
                if !(txtLitres.tag == sourceTag) {
                    txtLitres.text = result
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
        txtCubicMetres.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if didSegue {
            txtCubicMetres.becomeFirstResponder()
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
