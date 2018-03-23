//
//  TabBarController.swift
//  iconverter
//
//  Created by Damian Perera on 3/21/18.
//  Copyright © 2018 Damian Perera. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    func initializeTabs(){
        var allowedControllers = [UIViewController]()
        if let controllers = customizableViewControllers{
            for controller in controllers{
                if !(controller is WeightController){
                    allowedControllers.append(controller)
                }
            }
        }
        customizableViewControllers = allowedControllers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTabs()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let selectedItem = tabBar.items?.index(of: item)
        if selectedItem! == 4 {
            var tabBarFrame: CGRect = CGRect(x: self.view.frame.minX, y: self.view.frame.maxY, width:
                self.view.frame.width, height: 30.0)
            tabBarFrame.origin.y = self.view.frame.maxY
            self.tabBar.frame = tabBarFrame
        }
    }
    
}
