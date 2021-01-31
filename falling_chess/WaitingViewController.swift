//
//  WaitingViewController.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/09/13.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import UIKit
import NCMB

class WaitingViewController: UIViewController {
    
    var timer: Timer!
    var isAbleToChangePage: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.makeBackGround(isExistsNaviBar: false, isExistsTabBar: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isWaiting {
            timerStart()
        }
        else{
            isWaiting = true
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if(timer != nil){
            timer.invalidate()
        }
    }
    
    func timerStart(){
        // タイマーを開始するコード。一番引数が多いものを選ぶ。
        print("Timer is started!")
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(WaitingViewController.timerLoop), userInfo: nil, repeats: true)
    }
    
    @objc func timerLoop(){
        // データの取得
        let query = NCMBQuery(className: "Group")
        query?.whereKey("groupName", equalTo: groupNameG)
        var memos = [NCMBObject]()
        var numOfMembers: Int = 1
        
        query?.findObjectsInBackground({ (result, error) in
            if(error != nil){
                // エラーが発生したら、
                self.showAlertYT(titleYT: "エラー", textYT: error?.localizedDescription, buttonsYT: ["OK"], numOfmodeYT: 0)
            }
            else{
                // 読み込みが成功したら、
                memos = result as! [NCMBObject]
                if(memos.count != 0){
                    numOfMembers = memos.first?.object(forKey: "numOfMembers") as! Int
                    if(numOfMembers == 2){
                        if self.isAbleToChangePage {
                            self.isAbleToChangePage = false
                            self.performSegue(withIdentifier: "GameOnLine", sender: nil)
                        }
                    }
                    if(numOfMembers > 2){
                        self.showAlertYT(titleYT: "エラー", textYT: "予期せぬエラーが発生しました。", buttonsYT: ["OK"], numOfmodeYT: 0)
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                else{
                    self.showAlertYT(titleYT: "エラー", textYT: "予期せぬエラーが発生しました。", buttonsYT: ["OK"], numOfmodeYT: 0)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        })
    }
    
    @IBAction func back(){
        self.timer.invalidate()
        let query = NCMBQuery(className: "Group")
        query?.whereKey("groupName", equalTo: groupNameG)
        query?.findObjectsInBackground({ (result, error) in
            if(error != nil){
                // エラーが発生したら、
                self.showAlertYT(titleYT: "エラー", textYT: error?.localizedDescription, buttonsYT: ["OK"], numOfmodeYT: 0)
            }
            else{
                // 読み込みが成功したら、
                let messages = result as! [NCMBObject]
                if( messages.count != 0 ){
                    let textObject = messages.first
                    textObject?.deleteInBackground({ (error) in
                        if( error != nil ){
                            self.showAlertYT(titleYT: "エラー", textYT: error?.localizedDescription, buttonsYT: ["OK"], numOfmodeYT: 0)
                        }
                    })
                }
            }
        })
        self.dismiss(animated: true, completion: nil)
    }
}
