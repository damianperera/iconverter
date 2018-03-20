//
//  FirstViewController.swift
//  iconverter
//
//  Created by Damian Perera on 3/4/18.
//  Copyright © 2018 Damian Perera. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var testTextField: UITextField!
    var keyBoardHeight:CGFloat = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                               name: .UIKeyboardWillShow, object: nil)
        testTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                               name: .UIKeyboardWillShow, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        //this moves the tab bar above the keyboard for all devices
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as?
            NSValue)?.cgRectValue {
            self.keyBoardHeight = keyboardSize.origin.y - keyboardSize.height -
                (self.tabBarController?.tabBar.frame.height)!
        }
//        tabBarMoved = true
        var tabBarFrame: CGRect = (self.tabBarController?.tabBar.frame)!
        tabBarFrame.origin.y = self.keyBoardHeight
        UIView.animate(withDuration: 0.25, animations: {() -> Void in
            self.tabBarController?.tabBar.frame = tabBarFrame
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

