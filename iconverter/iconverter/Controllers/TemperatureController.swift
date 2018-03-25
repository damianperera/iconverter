//
//  TemperatureController.swift
//  iconverter
//
//  Created by Damian Perera on 3/4/18.
//  Copyright © 2018 Damian Perera. All rights reserved.
//

import UIKit

class TemperatureController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtCelcius: UITextField!
    @IBOutlet weak var txtFahrenheit: UITextField!
    @IBOutlet weak var txtKelvin: UITextField!
    var keyBoardHeight:CGFloat = 0
    var isKeyboardActive = false
    var tabBarOGHeight:CGFloat = 0
    var didSegue = false
    var setNegativeFor: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCelcius.delegate = self
        txtFahrenheit.delegate = self
        txtKelvin.delegate = self
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
            case .C:
                if !(txtCelcius.tag == sourceTag) {
                    txtCelcius.text = result
                }
            case .F:
                if !(txtFahrenheit.tag == sourceTag) {
                    txtFahrenheit.text = result
                }
            case .K:
                if !(txtKelvin.tag == sourceTag) {
                    txtKelvin.text = result
                }
            default:
                break
            }
        }
    }
    
    /**
        Action Components
     **/
    
    @IBAction func btnSaveOnSelect(_ sender: UIBarButtonItem) {
        var toSave:Dictionary<Unit, String> = Dictionary()
        for subview in view.subviews as [UIView] {
            if let textField = subview as? UITextField {
                switch textField.tag {
                case 0:
                    toSave[.C] = textField.text
                case 1:
                    toSave[.F] = textField.text
                case 2:
                    toSave[.K] = textField.text
                default:
                    break
                }
            }
        }
        HistoryModel().save(key: "temperature", dict: toSave)
    }
    
    @IBAction func btnNegativeOnSelect(_ sender: UIBarButtonItem) {
        setNegativeFor.text = "-"
    }
    
    @IBAction func txtCelciusOnEdit(_ sender: UITextField) {
        setNegativeFor = txtCelcius
        convert(from: .C, source: sender)
    }

    @IBAction func txtFahrenheitOnEdit(_ sender: UITextField) {
        setNegativeFor = txtFahrenheit
        convert(from: .F, source: sender)
    }
    
    @IBAction func txtKelvinOnEdit(_ sender: UITextField) {
        setNegativeFor = txtKelvin
        convert(from: .K, source: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        didSegue = true
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
    
    /**
        UI Components
    **/
    
    override func viewDidAppear(_ animated: Bool) {
        txtCelcius.becomeFirstResponder()
        setNegativeFor = txtCelcius
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if didSegue {
            txtCelcius.becomeFirstResponder()
            setNegativeFor = txtCelcius
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

