//
//  AddBackGround.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/10/05.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import Foundation
import UIKit

extension Int{
    public var f: CGFloat{
        return CGFloat(self)
    }
}
extension Double{
    public var f: CGFloat{
        return CGFloat(self)
    }
}
extension Float{
    public var f: CGFloat{
        return CGFloat(self)
    }
}


extension UIView{
    
    func getMargin() {
        cgOfTopMarginListG[0] += self.safeAreaInsets.top
        cgOfTopMarginListG[1] += self.safeAreaInsets.top
        cgOfBottomMarginListG[0] += self.safeAreaInsets.bottom
        cgOfBottomMarginListG[1] += self.safeAreaInsets.bottom
    }
    
    func makeBackGround(isExistsNaviBar: Bool, isExistsTabBar: Bool){
        
        self.deleteAllSubView()
        
        var scaleOfBBackGround: CGFloat!
        var scaleOfBackGround: CGFloat!
        
        let cgOfTopMargin: CGFloat!
        let cgOfBottomMargin: CGFloat!
        if(isExistsNaviBar){
            cgOfTopMargin = cgOfTopMarginListG[1]
        }
        else{
            cgOfTopMargin = cgOfTopMarginListG[0]
        }
        if(isExistsTabBar){
            cgOfBottomMargin = cgOfBottomMarginListG[1]
        }
        else{
            cgOfBottomMargin = cgOfBottomMarginListG[0]
        }
        
        let screenX = self.layer.bounds.size.width
        let screenY = self.layer.bounds.size.height - cgOfTopMargin - cgOfBottomMargin
    
        let backOfBackGroundImageView = OriginalImageView()
        let backGroundImageView = OriginalImageView()
    
        if( backOfBackGroundImageG != nil && backGroundImageG != nil){
            scaleOfBBackGround = max( screenX / (backOfBackGroundImageG?.size.width)!, (screenY + cgOfTopMargin + cgOfBottomMargin) / (backOfBackGroundImageG?.size.height)!)
            
            scaleOfBackGround = min(screenX / (backGroundImageG?.size.width)!, screenY / (backGroundImageG?.size.height)!)
            
            backOfBackGroundImageView.frame = CGRect(x: 0, y: 0, width: scaleOfBBackGround * (backOfBackGroundImageG?.size.width)!, height: scaleOfBBackGround * (backOfBackGroundImageG?.size.height)!)
            
            backOfBackGroundImageView.center = CGPoint(x: screenX / 2, y: (screenY + cgOfTopMargin + cgOfBottomMargin) / 2)
            
            backOfBackGroundImageView.image = backOfBackGroundImageG
            
            
            backGroundImageView.frame = CGRect(x: 0, y: 0, width: scaleOfBackGround * (backGroundImageG?.size.width)!, height: scaleOfBackGround * (backGroundImageG?.size.height)!)
            
            backGroundImageView.center = CGPoint(x: screenX / 2, y: screenY / 2 + cgOfTopMargin)
            
            backGroundImageView.image = backGroundImageG
            
            
            self.addSubview(backOfBackGroundImageView)
            self.addSubview(backGroundImageView)
            
            self.sendSubviewToBack(backGroundImageView)
            self.sendSubviewToBack(backOfBackGroundImageView)
        }
    }
    
    func deleteAllSubView(){
        let subviews = self.subviews
        for subview in subviews{
            if subview is OriginalImageView {
                subview.removeFromSuperview()
            }
            if subview is DarkView {
                subview.removeFromSuperview()
            }
        }
    }
    
    func showThinking(isRotate: Bool, mySide: Int){
        let darkView = DarkView()
        darkView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        darkView.showThinkingChild(isRotate: isRotate, mySide: mySide)
        self.addSubview(darkView)
    }
    
    func deleteDark(){
        let subviews = self.subviews
        for subview in subviews{
            if subview is DarkView {
                subview.removeFromSuperview()
            }
        }
    }
    
    func darkPromotion(_ turn: Int){
        isNotSellectingPromotionG = false
        let darkView = DarkView()
        darkView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        darkView.promotionSelect(turn)
        self.addSubview(darkView)
    }
}

class OriginalImageView: UIImageView {}
