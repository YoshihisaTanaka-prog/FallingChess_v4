//
//  SupportFuncsMadeByYoshihisaTanaka.swift
//  InstaSample
//
//  Created by 田中義久 on 2020/09/06.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import Foundation
import UIKit
import NCMB

var alertControllersYT: [UIAlertController] = []

extension UIViewController{
    func processOfShowAlertYT(numOfModeYT: Int, numOfButtonIdYT: Int){
        switch [numOfModeYT,numOfButtonIdYT] {
        case [1,0]:
            isPlaying = false
//            self.clossePage()
//            self.view.closeFusuma(isExistsNaviBar: false, isExistsTabBar: false)
            self.dismiss(animated: true, completion: nil)
            break
            
            //    case [2,0]:
            //        insteadOfSelfYT()?.dismiss(animated: true, completion: nil)
            //        break
            //
            //    case [2,1]:
            //        let storyboard: UIStoryboard = (insteadOfSelfYT()?.storyboard!)!
            //        let newView = storyboard.instantiateViewController(identifier: "NewGame") as! NewGameViewController
            //        insteadOfSelfYT()?.present(newView, animated: true, completion: nil)
            //        break
            //
            //    case [3,0]:
            //        // データの取得
            //        let query = NCMBQuery(className: "Group")
            //        query?.whereKey("groupName", equalTo: groupNameG)
            //
            //        query?.findObjectsInBackground({ (result, error) in
            //            if(error != nil){
            //                // エラーが発生したら、
            //                showAlertYT(titleYT: "エラー", textYT: error?.localizedDescription, buttonsYT: ["OK"], numOfmodeYT: 0)
            //            }
            //            else{
            //                // 読み込みが成功したら、
            //                let messages = result as! [NCMBObject]
            //                let textObject = messages.first
            //                textObject?.deleteInBackground({ (error) in
            //                    if( error != nil ){
            //                        showAlertYT(titleYT: "エラー", textYT: error?.localizedDescription, buttonsYT: ["OK"], numOfmodeYT: 0)
            //                    }
            //                })
            //            }
            //        })
            //
            //        insteadOfSelfYT()?.dismiss(animated: true, completion: nil)
            //        break
            //
            //    case [3,1]:
            //        let storyboard: UIStoryboard = (insteadOfSelfYT()?.storyboard!)!
            //        let newView = storyboard.instantiateViewController(identifier: "NewGame") as! NewGameViewController
            //        insteadOfSelfYT()?.present(newView, animated: true, completion: nil)
            //        break
            
        case [4,0]:
            isPlaying = false
//            self.view.closeFusuma(isExistsNaviBar: false, isExistsTabBar: false)
            self.dismiss(animated: true, completion: nil)
            break
            
        case [5,0]:
            isPlaying = false
//            self.view.closeFusuma(isExistsNaviBar: false, isExistsTabBar: false)
            self.dismiss(animated: true, completion: nil)
            break
            
        case [6,0]:
            break
            
        case [7,0]:
            isPlaying = false
//            self.view.closeFusuma(isExistsNaviBar: false, isExistsTabBar: false)
            self.dismiss(animated: true, completion: nil)
            break
            
        case [8,0]:
            isPlaying = false
//            self.view.closeFusuma(isExistsNaviBar: false, isExistsTabBar: false)
            self.dismiss(animated: true, completion: nil)
            break
            
        case [9,0]:
            isPlaying = false
//            self.view.closeFusuma(isExistsNaviBar: false, isExistsTabBar: false)
           self.dismiss(animated: true, completion: nil)
            break
            
        case [10,0]:
            if(statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA != 30){
                statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA = statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA + 4
                drawKoma()
            }
            isNotSellectingPromotionG = true
            break
            
        case [10,1]:
            if(statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA != 30){
                statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA = statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA + 3
                drawKoma()
            }
            isNotSellectingPromotionG = true
            break
            
        case [10,2]:
            if(statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA != 30){
                statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA = statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA + 2
                drawKoma()
            }
            isNotSellectingPromotionG = true
            break
            
        case [10,3]:
            if(statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA != 30){
                statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA = statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA + 1
                drawKoma()
            }
            isNotSellectingPromotionG = true
            break
            
        case [11,0]:
            if(statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA != 30){
                statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA = statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA + 10
                drawKoma()
            }
            isNotSellectingPromotionG = true
            break
            
        case [11,1]:
            isNotSellectingPromotionG = true
            break
            
        default:
            break
        }
    }
    
    // ここから下は書き換えないで。
    
    // alert系
    
    func showAlertYT(titleYT: String, textYT: String?, buttonsYT: [String], numOfmodeYT: Int){
        showAlertBasicYT(titleYT: titleYT, textYT: textYT, buttonsYT: buttonsYT, numOfmodeYT: numOfmodeYT, isQuick: false, isActionSheet: false)
    }
    
    func showAlertQuickYT(titleYT: String, textYT: String?, buttonsYT: [String], numOfmodeYT: Int){
        showAlertBasicYT(titleYT: titleYT, textYT: textYT, buttonsYT: buttonsYT, numOfmodeYT: numOfmodeYT, isQuick: true, isActionSheet: false)
    }
    
    func showAlertActionSheetYT(titleYT: String, textYT: String?, buttonsYT: [String], numOfmodeYT: Int){
        showAlertBasicYT(titleYT: titleYT, textYT: textYT, buttonsYT: buttonsYT, numOfmodeYT: numOfmodeYT, isQuick: false, isActionSheet: true)
    }
    
    func showAlertActionSheetQuickYT(titleYT: String, textYT: String?, buttonsYT: [String], numOfmodeYT: Int){
        showAlertBasicYT(titleYT: titleYT, textYT: textYT, buttonsYT: buttonsYT, numOfmodeYT: numOfmodeYT, isQuick: true, isActionSheet: true)
    }
    
    func showAlertBasicYT(titleYT: String, textYT: String?, buttonsYT: [String], numOfmodeYT: Int, isQuick: Bool, isActionSheet: Bool){
        
        isAbleToChangePageG = false
        
        if(isActionSheet){
            if( isQuick && alertControllersYT.count != 0 ){
                alertControllersYT.insert(UIAlertController(title: titleYT, message: textYT!, preferredStyle: .actionSheet),at: 1)
            }
            else{
                alertControllersYT.append(UIAlertController(title: titleYT, message: textYT!, preferredStyle: .actionSheet))
            }
        }
        else{
            if( isQuick && alertControllersYT.count != 0 ){
                alertControllersYT.insert(UIAlertController(title: titleYT, message: textYT!, preferredStyle: .alert),at: 1)
            }
            else{
                alertControllersYT.append(UIAlertController(title: titleYT, message: textYT!, preferredStyle: .alert))
            }
        }
        
        var actions = [UIAlertAction]()
        
        for i in 0..<buttonsYT.count {
            actions.append(UIAlertAction(title: buttonsYT[i], style: .default) { (action) in
                self.processOfShowAlertYT(numOfModeYT: numOfmodeYT, numOfButtonIdYT: i)
                insteadOfSelfYT()?.navigationController?.popViewController(animated: true)
                alertControllersYT.remove(at: 0)
                if( alertControllersYT.count > 0 ){
                    self.present(alertControllersYT[0],animated: true, completion:  nil)
                }
                else{
                    isAbleToChangePageG = true
                }
            })
            if( isQuick && alertControllersYT.count > 1 ){
                alertControllersYT[1].addAction(actions[i])
            }
            else{
                alertControllersYT.last!.addAction(actions[i])
            }
        }
        if( alertControllersYT.count == 1 ){
            self.present(alertControllersYT[0],animated: true, completion:  nil)
        }
    }
}


// selfの代わり
func insteadOfSelfYT() -> UIViewController? {
    var windowYT = UIWindow()
    for winYT in UIApplication.shared.windows {
        if winYT.isKeyWindow {
            windowYT = winYT
        }
    }
    if let rootViewControllerYT = windowYT.rootViewController {
        var topViewControllerYT: UIViewController = rootViewControllerYT

        while let presentedViewControllerYT = topViewControllerYT.presentedViewController {
            topViewControllerYT = presentedViewControllerYT
        }

        return topViewControllerYT
    } else {
        return nil
    }
}

// 乱数
func rand(minYT: Int, maxYT: Int)-> Int{
    
    var localMinYT: Int = 0
    var localMaxYT: Int = 0
    var saYT: Int = 0
    
    if( minYT == maxYT ){
        return minYT
    }
    else if( minYT > maxYT ){
        localMinYT = maxYT
        localMaxYT = minYT
    }
    else{
        localMinYT = minYT
        localMaxYT = maxYT
    }
    saYT = localMaxYT - localMinYT + 1
    return localMinYT + Int(arc4random_uniform(UInt32(saYT)))
}
