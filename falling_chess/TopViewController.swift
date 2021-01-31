//
//  TopViewController.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/10/07.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import UIKit
import NCMB

class TopViewController: UIViewController {
    
    let imageView = UIImageView()
    let logoImageView = UIImageView()
    var userNameMemo: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingFirstOfAll()
        
        if(isFirstTime){
            createData()
        }
            
        else{
            let query = NCMBQuery(className: "Users")
            query?.whereKey("AuserName", equalTo: userName)
            query?.findObjectsInBackground({ (result, error) in
                if(error != nil){
                    // エラーが発生したら、
                    self.showAlertQuickYT(titleYT: "エラー", textYT: error?.localizedDescription, buttonsYT: ["OK"], numOfmodeYT: 0)
                }
                else{
                    let users = result as! [NCMBObject]
                    if(users.count == 0){
                        self.createData()
                    }
                    else{
                        let user = users[0]
                        user.setObject(numOfGameMode, forKey: "numOfGameMode")
                        user.setObject(numOfPeriod, forKey: "numOfPeriod")
                        user.setObject(numOfTimeMode, forKey: "numOfTimeMode")
                        user.setObject(isJump, forKey: "isJump")
                        user.setObject(isSucide, forKey: "isSucide")
                        user.setObject(isNotice, forKey: "isNotice")
                        user.setObject(isShowBanchi, forKey: "isShowBanchi")
                        user.setObject(numOfDesign, forKey: "numOfDesign")
                        user.setObject(numOfButtonAlpha, forKey: "numOfButtonAlpha")
                        user.setObject(isFirstTime, forKey: "isFirstTime")
                        user.saveInBackground { (error) in
                            if(error != nil){
                                self.showAlertQuickYT(titleYT: "エラー", textYT: error?.localizedDescription, buttonsYT: ["OK"], numOfmodeYT: 0)
                            }
                        }
                    }
                }
            })
        }
        
        let name = "LG" + String(numOfDesign) + ".PNG"
        let logoImage = UIImage(named: name)
        if(backOfBackGroundImageG != nil && logoImage != nil){
            let screenX = self.view.layer.bounds.size.width
            let screenY = self.view.layer.bounds.size.height
            let scaleOfBBackGround = max( screenX / (backOfBackGroundImageG?.size.width)!, screenY / (backOfBackGroundImageG?.size.height)!)
            imageView.frame = CGRect(x: 0, y: 0, width: scaleOfBBackGround * (backOfBackGroundImageG?.size.width)!, height: scaleOfBBackGround * (backOfBackGroundImageG?.size.height)!)
            
            imageView.center = CGPoint(x: screenX / 2, y: screenY / 2)
            
            imageView.image = backOfBackGroundImageG
            self.view.addSubview(imageView)
            
            if(screenX < 900){
                logoImageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
            }
            else{
                logoImageView.frame = CGRect(x: 0, y: 0, width: screenX / 3, height: screenX / 3)
            }
            
            logoImageView.center = CGPoint(x: screenX / 2, y: screenY / 2)
            
            logoImageView.image = logoImage
            logoImageView.alpha = 0
            self.view.addSubview(logoImageView)
            self.view.sendSubviewToBack(logoImageView)
            self.view.sendSubviewToBack(imageView)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.logoImageView.alpha = 1
        }
        self.view.getMargin()
        wait5()
    }
    
    
    var waitingTimer: Timer!
    var isStop = false
    
    func wait5(){
        waitingTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self as Any, selector: #selector(self.waiting) , userInfo: nil, repeats: true)
    }
    @objc func waiting(){
        if(isStop){
            waitingTimer.invalidate()
            goToMain()
        }
        else{
            isStop = true
        }
    }
    
    func goToMain() {
        if(isFirstTime){
            self.performSegue(withIdentifier: "goToCaution", sender: nil)
        }
        else{
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationBarController")
            var window = UIWindow()
            for win in UIApplication.shared.windows {
                if win.isKeyWindow {
                    window = win
                }
            }
            window.rootViewController = rootViewController
        }
    }
    
    func createData(){
        let user = NCMBObject(className: "Users")
        userNameMemo = String(format: "%010d", arc4random())
        user?.setObject(userNameMemo,forKey: "AuserName")
        user?.setObject(numOfGameMode, forKey: "numOfGameMode")
        user?.setObject(numOfPeriod, forKey: "numOfPeriod")
        user?.setObject(numOfTimeMode, forKey: "numOfTimeMode")
        user?.setObject(isJump, forKey: "isJump")
        user?.setObject(isSucide, forKey: "isSucide")
        user?.setObject(isNotice, forKey: "isNotice")
        user?.setObject(isShowBanchi, forKey: "isShowBanchi")
        user?.setObject(numOfDesign, forKey: "numOfDesign")
        user?.setObject(numOfButtonAlpha, forKey: "numOfButtonAlpha")
        user?.setObject(isFirstTime, forKey: "isFirstTime")
        user?.saveInBackground { (error) in
            if(error != nil){
                self.showAlertQuickYT(titleYT: "エラー", textYT: error?.localizedDescription, buttonsYT: ["OK"], numOfmodeYT: 0)
            }
            else{
                self.performSegue(withIdentifier: "goToCaution", sender: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 値を渡すコード
        // 次の画面を取得
        if(segue.identifier == "goToCaution" ){
            let View2 = segue.destination as! CautionViewController
            // 次の画面の変数にこの画面の変数を入れている
            View2.userNameMemo = userNameMemo
            View2.isFirstCall = isFirstTime
        }
    }
}
