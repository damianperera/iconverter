//
//  WeightController.swift
//  iconverter
//
//  Created by Damian Perera on 3/4/18.
//  Copyright © 2018 Damian Perera. All rights reserved.
//

import UIKit

class WeightController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtStones: UITextField!
    @IBOutlet weak var txtStonePounds: UITextField!
    @IBOutlet weak var txtPounds: UITextField!
    @IBOutlet weak var txtOunces: UITextField!
    @IBOutlet weak var txtGrams: UITextField!
    @IBOutlet weak var txtKilograms: UITextField!
    var keyBoardHeight:CGFloat = 0
    var isKeyboardActive = false
    var tabBarOGHeight:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        txtStones.delegate = self
        txtStonePounds.delegate = self
        txtPounds.delegate = self
        txtOunces.delegate = self
        txtGrams.delegate = self
        txtKilograms.delegate = self
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
            case .kg:
                if !(txtKilograms.tag == sourceTag) {
                    txtKilograms.text = result
                }
            case .g:
                if !(txtGrams.tag == sourceTag) {
                    txtGrams.text = result
                }
            case .oz:
                if !(txtOunces.tag == sourceTag) {
                    txtOunces.text = result
                }
            case .lbs:
                if !(txtPounds.tag == sourceTag) {
                    txtPounds.text = result
                }
            case .st_lbs:
                if !(txtStonePounds.tag == sourceTag) {
                    txtStonePounds.text = result
                }
            case .st:
                if !(txtStones.tag == sourceTag) {
                    txtStones.text = result
                }
            default:
                break
            }
        }
    }
    
    /**
        Action Listerners
    **/
    
    @IBAction func txtKilogramsOnEdit(_ sender: UITextField) {
        convert(from: .kg, source: sender)
    }
    
    @IBAction func txtGramsOnEdit(_ sender: UITextField) {
        convert(from: .g, source: sender)
    }
    
    @IBAction func txtOuncesOnEdit(_ sender: UITextField) {
        convert(from: .oz, source: sender)
    }
    
    @IBAction func txtPoundsOnEdit(_ sender: UITextField) {
        convert(from: .lbs, source: sender)
    }
    
    @IBAction func txtStonePoundsOnEdit(_ sender: UITextField) {
        convert(from: .st_lbs, source: sender)
    }
    
    @IBAction func txtStonesOnEdit(_ sender: UITextField) {
        convert(from: .st, source: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! HistoryController
        destination.segueFromConroller = "weight"
    }

    @IBAction func backToWeightController(storyboard: UIStoryboardSegue){

    }
    
    /**
        UI Components
     **/
    
    override func viewDidAppear(_ animated: Bool) {
        txtKilograms.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)),
                                               name: .UIKeyboardWillShow, object: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func dismissFirstResponders() {
        self.view.subviews.filter({$0 is UITextField}).forEach({$0.resignFirstResponder()})
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
    
    func switchTabBarTextOffset() {
        if isKeyboardActive {
            if let count = self.tabBarController?.tabBar.items?.count {
                for i in 0...(count-1) {
                    self.tabBarController?.tabBar.items?[i].titlePositionAdjustment = UIOffsetMake(0, 0)
                }
            }
        } else {
            if let count = self.tabBarController?.tabBar.items?.count {
                for i in 0...(count-1) {
                    self.tabBarController?.tabBar.items?[i].titlePositionAdjustment = UIOffsetMake(0, 0)
                }
            }
        }
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
        
        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 4 && newText.characters.count <= 9
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

