//
//  Fusuma.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/10/15.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func clossePage() {
        closeFusuma(isExistsNaviBar: false, isExistsTabBar: false)
        self.dismiss(animated: false, completion: nil)
    }
    
    func fusumaFirst(isOpen: Bool, isExistsNavigationBar: Bool, isExistsTabBar: Bool){
        
        let screenX = self.view.layer.bounds.size.width
        let screenY = self.view.layer.bounds.size.height
        
        let fusumaView = FusumaView()
        fusumaView.iENB = isExistsNavigationBar
        fusumaView.iETB = isExistsTabBar
        fusumaView.screenOfX = screenX
        fusumaView.screenOfY = screenY
        
        fusumaView.makeFusuma(isOpen: isOpen)
        self.view.addSubview(fusumaView)
        self.view.bringSubviewToFront(fusumaView)
    }
    
    func openFusuma(isExistsNaviBar: Bool, isExistsTabBar: Bool) {
        
        let subViews = self.view.subviews
        for subView in subViews{
            if(subView is FusumaView){
                subView.removeFromSuperview()
            }
        }
        
        let screenX = self.view.layer.bounds.size.width
        let screenY = self.view.layer.bounds.size.height
        
        let fusumaView = FusumaView()
        fusumaView.frame = CGRect(x: 0, y: 0, width: screenX, height: screenY)
        self.view.addSubview(fusumaView)
        fusumaView.openFusumaMove(isExistsNaviBar: isExistsNaviBar, isExistsTabBar: isExistsTabBar, screenX: screenX,screenY: screenY)
        //        fusumaView.removeFromSuperview()
    }
    
    func closeFusuma(isExistsNaviBar: Bool, isExistsTabBar: Bool) {
        
        let screenX = self.view.layer.bounds.size.width
        let screenY = self.view.layer.bounds.size.height
        
        let fusumaView = FusumaView()
        fusumaView.frame = CGRect(x: 0, y: 0, width: screenX, height: screenY)
        self.view.addSubview(fusumaView)
        fusumaView.closeFusumaMove(isExistsNaviBar: isExistsNaviBar, isExistsTabBar: isExistsTabBar, screenX: screenX,screenY: screenY)
        fusumaView.removeFromSuperview()
    }
    
    func hideToFusuma(isExistsNaviBar: Bool, isExistsTabBar: Bool){
        let subViews = self.view.subviews
        for subView in subViews {
            self.view.sendSubviewToBack(subView)
        }
        self.view.makeBackGround(isExistsNaviBar: isExistsNaviBar, isExistsTabBar: isExistsTabBar)
    }
}

class FusumaView: UIView{
    
    var fusumaSubViews : [UIView]! = []
    
    var screenOfX: CGFloat!
    var screenOfY: CGFloat!
    var iENB: Bool!
    var iETB: Bool!
    
    func makeFusuma(isOpen: Bool){
        
        for i in 0..<2{
            let subView = UIView()
            
            
            subView.frame = CGRect(x: 0, y: 0, width: screenOfX, height: screenOfY)
            subView.center = CGPoint(x: screenOfX - screenOfX / 2 * i.f, y: screenOfY / 2)
            
            let imageView = UIImageView()
            let imageName = "f" + String(numOfGameMode * 10 + numOfDesign + 10) + ".png"
            var image = UIImage(named: imageName)
            if image == nil {
                image = UIImage(named: "making.png")
            }
            
            let imageX = (image?.size.width)!
            let imageY = (image?.size.height)!
            let scale = max( screenOfX / imageX , screenOfY / imageY )
            
            imageView.frame = CGRect(x: 0, y: 0, width: scale * imageX, height: scale * imageY)
            imageView.image = image
            imageView.center = CGPoint(x: screenOfX / 2, y: screenOfY / 2)
            subView.addSubview(imageView)
            
            fusumaSubViews.append(UIView())
            fusumaSubViews[i].frame = CGRect(x: 0, y: 0, width: screenOfX / 2, height: screenOfY)
            if isOpen {
                fusumaSubViews[i].center = CGPoint(x: i.f * screenOfX / 2 + screenOfX / 4, y: screenOfY / 2)
            }
            else{
                fusumaSubViews[i].center = CGPoint(x: 3.f * i.f * screenOfX / 2 - screenOfX / 4, y: screenOfY / 2)
            }
            fusumaSubViews[i].clipsToBounds = true
            fusumaSubViews[i].addSubview(subView)
            self.addSubview(fusumaSubViews[i])
        }
    }
    
    func openFusumaMove(isExistsNaviBar: Bool, isExistsTabBar: Bool, screenX: CGFloat, screenY: CGFloat) {
        
        screenOfX = screenX
        screenOfY = screenY
        iENB = isExistsNaviBar
        iETB = isExistsTabBar
        
        waitOpen()
        
        fusumaSubViews.removeAll()
    }
    
    func closeFusumaMove(isExistsNaviBar: Bool, isExistsTabBar: Bool, screenX: CGFloat, screenY: CGFloat) {
        
        screenOfX = screenX
        screenOfY = screenY
        iENB = isExistsNaviBar
        iETB = isExistsTabBar
        
        waitClose()
        
        fusumaSubViews.removeAll()
    }
    
    var waitingTimer: Timer!
    var isStop = false
    func waitOpen(){
        waitingTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self as Any, selector: #selector(self.waitingOpen) , userInfo: nil, repeats: true)
    }
    @objc func waitingOpen(){
        if(isStop){
            waitingTimer.invalidate()
            makeFusuma(isOpen: true )
            
            UIView.animate(withDuration: 1) {
                for i in 0..<2 {
                    self.fusumaSubViews[i].center = CGPoint(x: 3.f * i.f * self.screenOfX / 2 - self.screenOfX / 4, y: self.screenOfY / 2)
                }
            }
        }
        else{
            isStop = true
        }
    }
    
    func waitClose(){
        waitingTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self as Any, selector: #selector(self.waitingClose) , userInfo: nil, repeats: true)
    }
    @objc func waitingClose(){
        if(isStop){
            waitingTimer.invalidate()
            
            makeFusuma(isOpen: false)
            
            UIView.animate(withDuration: 1) {
                for i in 0..<2 {
                    self.fusumaSubViews[i].center = CGPoint(x: i.f * self.screenOfX / 2 + self.screenOfX / 4, y: self.screenOfY / 2)
                }
            }
        }
        else{
            isStop = true
        }
    }
}
