//
//  FirstViewController.swift
//  iconverter
//
//  Created by Damian Perera on 3/4/18.
//  Copyright © 2018 Damian Perera. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

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
    }
    
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
    
    override func viewDidDisappear(_ animated: Bool) {

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

