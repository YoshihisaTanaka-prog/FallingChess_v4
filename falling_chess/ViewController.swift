//
//  ViewController.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/08/17.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import UIKit
import NCMB

class ViewController: UIViewController {
    
    
//    var screenButtonArray: [UIButton] = []
//    var button = OriginalButtons()
    var screenButtonArray: [OriginalButton] = []
    var userNameMemo: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = NCMBQuery(className: "Users")
        query?.whereKey("AuserName", equalTo: userName)
        query?.findObjectsInBackground({ (result, error) in
            if(error != nil){
                // エラーが発生したら、
                self.showAlertYT(titleYT: "エラー", textYT: error?.localizedDescription, buttonsYT: ["OK"], numOfmodeYT: 0)
            }
            else{
                // 読み込みが成功したら、
                let users = result as! [NCMBObject]
                self.userNameMemo = users[0].object(forKey: "AuserName") as? String
                if( users[0].objectId != self.userNameMemo ){
                    self.performSegue(withIdentifier: "goToCaution", sender: nil)
                }
            }
        })
        query?.whereKey("isFirstTime", equalTo: true)
        query?.findObjectsInBackground({ (result, error) in
            if(error != nil){
                // エラーが発生したら、
                self.showAlertYT(titleYT: "エラー", textYT: error?.localizedDescription, buttonsYT: ["OK"], numOfmodeYT: 0)
            }
            else{
                // 読み込みが成功したら、
                let users = result as! [NCMBObject]
                for user in users{
                    user.deleteInBackground({ (error) in
                        if( error != nil ){
                            self.showAlertYT(titleYT: "エラー", textYT: error?.localizedDescription, buttonsYT: ["OK"], numOfmodeYT: 0)
                        }
                    })
                }
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.makeBackGround(isExistsNaviBar: true, isExistsTabBar: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.alpha = numOfButtonAlpha.f
        let size: CGFloat = max(300.f, self.view.layer.frame.size.width / 2.f)
        createButtonArray(titles: ["二人プレイ","オンライン","設定"], size: size)
        self.view.makeBackGround(isExistsNaviBar: true, isExistsTabBar: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        for button in screenButtonArray{
            button.removeFromSuperview()
        }
        screenButtonArray.removeAll()
    }
    
    func createButtonArray(titles: [String], size: CGFloat){
        for i in 0..<titles.count{
            let button = OriginalButton(type: UIButton.ButtonType.system)
            button.makeButton(size: size * 2 / 7, titles: titles, num: i)
            button.alpha = numOfButtonAlpha.f
            button.addTarget(self, action: #selector(buttonEvent(_:)), for: UIControl.Event.touchUpInside)
            button.tag = i
//             viewに追加する
            self.view.addSubview(button)
            screenButtonArray.append(button)
        }
    }
    
    @objc func buttonEvent(_ sender: UIButton){
        switch sender.tag {
        case 0:
            self.performSegue(withIdentifier: "Game2P", sender: nil)
            break

        case 1:
            self.performSegue(withIdentifier: "GameOnLine", sender: nil)
            break
            
        case 2:
            self.performSegue(withIdentifier: "Set", sender: nil)
            break
            
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 値を渡すコード
        // 次の画面を取得
        if(segue.identifier == "goToCaution" ){
            let View2 = segue.destination as! CautionViewController
            // 次の画面の変数にこの画面の変数を入れている
            View2.userNameMemo = userNameMemo
            View2.isFirstCall = true
        }
    }
}

