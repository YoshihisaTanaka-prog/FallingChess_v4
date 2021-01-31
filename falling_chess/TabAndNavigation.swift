//
//  TabAndNavigation.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/10/15.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import Foundation
import UIKit

class OriginalTabBarController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = colorListG[0][numOfDesign - 1]
        self.tabBar.tintColor = colorListG[1][numOfDesign - 1]
        
        self.tabBar.alpha = numOfButtonAlpha.f
        
        if numOfGettingMarginFirst < 10{
            cgOfBottomMarginListG[1] += self.tabBar.frame.size.height
            numOfGettingMarginFirst += 10
        }
    }
}
class OriginalNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationBar.barTintColor = colorListG[0][numOfDesign - 1]
        self.navigationBar.tintColor = colorListG[1][numOfDesign - 1]
        
        if(numOfGettingMarginFirst % 10 == 0){
            cgOfTopMarginListG[1] += self.navigationBar.frame.size.height
            numOfGettingMarginFirst += 1
        }
    }
}
