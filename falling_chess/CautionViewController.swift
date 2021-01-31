//
//  CautionViewController.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/10/19.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import UIKit
import NCMB

class CautionViewController: UIViewController {
    var userNameMemo : String!
    var isFirstCall : Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = NCMBQuery(className: "Users")
        query?.whereKey("AuserName", equalTo: userNameMemo)
        query?.findObjectsInBackground({ (result, error) in
            if(error != nil){
                // エラーが発生したら、
                self.showAlertYT(titleYT: "エラー", textYT: error?.localizedDescription, buttonsYT: ["OK"], numOfmodeYT: 0)
            }
            else{
                // 読み込みが成功したら、
                let users = result as! [NCMBObject]
                let user = users[0]
                user.setObject(user.objectId, forKey: "AuserName")
                user.setObject(false, forKey: "isFirstTime")
                user.saveInBackground({ (error) in
                    if(error != nil){
                        // エラーが発生したら、
                        self.showAlertYT(titleYT: "エラー", textYT: error?.localizedDescription, buttonsYT: ["OK"], numOfmodeYT: 0)
                    }
                    else{
                        // 保存が成功したら、
                        userName = user.object(forKey: "AuserName") as! String
                        let ud = UserDefaults.standard
                        ud.set(false, forKey: "isFirstTime")
                        ud.set(userName, forKey: "userName")
                        ud.synchronize()
                    }
                })
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.makeBackGround(isExistsNaviBar: false, isExistsTabBar: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let alert: UIAlertController!
        if(isFirstCall){
            alert = UIAlertController(title: "注意", message: "このアプリではより良いサービスを提供するために、個人情報が特定できないような形式でアプリ内のデータを収集します。", preferredStyle: .alert)
        }
        else{
            alert = UIAlertController(title: "エラー", message: "初期設定に失敗しました。", preferredStyle: .alert)
        }
        
        let alertOkAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // OKボタンを押した後のアクション
            alert.dismiss(animated: true, completion: nil)
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
        alert.addAction(alertOkAction)
        self.present(alert, animated: true, completion: nil)
    }
}
