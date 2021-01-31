//
//  LogInViewController.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/09/12.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import UIKit
import NCMB

class LogInViewController: UIViewController, UITableViewDelegate, UITableViewDataSource ,UINavigationControllerDelegate{

    @IBOutlet var tableView: UITableView!
    @IBOutlet var groupNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var reloadButton: UIButton!
    
    var groupNameList: [String] = []
    var numOfgameModeList:[Int] = []
    var periodList: [Int] = []
    var numOfTimeModeList: [Int] = []
    var isSucideList: [Bool] = []
    var isJumpList: [Bool] = []
    var isNoticeList: [Bool] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        numOfShuffledArray.removeAll()
        
        tableView.alpha = numOfButtonAlpha.f
        groupNameTextField.alpha = numOfButtonAlpha.f
        passwordTextField.alpha = numOfButtonAlpha.f
        loginButton.alpha = numOfButtonAlpha.f
        reloadButton.alpha = numOfButtonAlpha.f
    }
    
    override func viewWillAppear(_ animated: Bool) {
        alertControllersYT.removeAll()
        self.view.makeBackGround(isExistsNaviBar: true, isExistsTabBar: true)
        
        var numOfPeriodMemo: Int!
        var numOfGameModeMemo: Int!
        var numOfTimeModeMemo: Int!
        var isSucideMemo: Bool!
        var isJumpMemo: Bool!
        var isNoticeMemo: Bool!
        
        let ud = UserDefaults.standard
        
        numOfPeriodMemo = ud.integer(forKey: "numOfPeriod")
        numOfPeriod = numOfPeriodMemo!
        
        numOfGameModeMemo = ud.integer(forKey: "numOfGameMode")
        numOfGameMode = numOfGameModeMemo!
        
        numOfTimeModeMemo = ud.integer(forKey: "numOfTimeMode")
        numOfTimeMode = numOfTimeModeMemo!
        
        isSucideMemo = ud.bool(forKey: "isSucide")
        isSucide = isSucideMemo!
        
        isJumpMemo = ud.bool(forKey: "isJump")
        isJump = isJumpMemo!
        
        isNoticeMemo = ud.bool(forKey: "isNotice")
        isNotice = isNoticeMemo!

        load()
        
        // cellの高さ
//        tableView.rowHeight = 150
        // データ・ソースメソッドをこのファイル内で処理しますよ。
        tableView.dataSource = self
        // デリゲートメソッドをselfに任せる
        tableView.delegate = self
        
        // TableViewの不要な線を消すためのコード
        tableView.tableFooterView = UIView()
        
        // カスタムセルの登録
        let nib1 = UINib(nibName: "TableViewCell", bundle: Bundle.main)
        let nib2 = UINib(nibName: "AdvertiseTableViewCell", bundle: Bundle.main)
        // (「register(nib: UINib?, forCellReuseIdentifier: String)」を選ぶ。)
        tableView.register(nib1, forCellReuseIdentifier: "Cell1")
        tableView.register(nib2, forCellReuseIdentifier: "Cell2")
        
        tableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    // 1. TableViewに表示するデータの個数を決める。「numberOfRowsInSection」がついているものを選ぶ。(Rowは行を意味する英単語)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 具体的に数値を入れても良いが「○○.count」と書くと自動的に数えてくれる。
        // データの一部だけ表示させ得たい場合は具体的に数値を入力する。
        // データ数よりも多い場合はエラーが出るので注意が必要。
        return max(groupNameList.count,1)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(groupNameList.count == 0){
            return 600
        }
        return 150
    }
    
    // 2. TableViewのCellに表示するデータの内容を決める。「cellForRowAt」がついているものを選ぶ。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(groupNameList.count == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2") as! AdvertiseTableViewCell
            // 表示させる内容を決める。
            
            cell.layer.cornerRadius = 20
            cell.clipsToBounds = true
            
            cell.messageLabel.text = """
            現在部屋を作っているユーザがいません。
            ユーザー数が少ないようです。
            
            どうか、このアプリを宣伝していただけないでしょうか？
            
            このアプリを宣伝するにはここをタップしてください。
            
            お願いします。
            お願いします。
            お願いします。
            お願いします。
            お願いします。
            """
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1") as! TableViewCell
            
            // 表示させる内容を決める。
            
            cell.layer.cornerRadius = 20
            cell.clipsToBounds = true
            
            cell.groupNameLabel.text = groupNameList[indexPath.row]
            switch numOfgameModeList[indexPath.row] {
            case 0:
                cell.gameModeLabel.text = "チェス"
                cell.view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
                
            case 1:
                cell.gameModeLabel.text = "将棋"
                cell.view.backgroundColor = UIColor(red: 1, green: 1, blue: 0.9, alpha: 1)
                
            case 2:
                cell.gameModeLabel.text = "マークルック"
                
            case 3:
                cell.gameModeLabel.text = "シャトランジ"
                
            default:
                break
            }
            cell.periodLabel.text = String(periodList[indexPath.row])
            switch numOfTimeModeList[indexPath.row] {
            case 0:
                cell.remainTimeLabel.text = "1手10秒"
                
            case 1:
                cell.remainTimeLabel.text = "1手30秒"
                
            case 2:
                cell.remainTimeLabel.text = "3分"
                
            case 3:
                cell.remainTimeLabel.text = "10分"
                
            default:
                break
            }
            switch isSucideList[indexPath.row] {
            case true:
                cell.isSucideLabel.text = "ON"
                
            case false:
                cell.isSucideLabel.text = "OFF"
            }
            switch isJumpList[indexPath.row] {
            case true:
                cell.isJumpLabel.text = "ON"
                
            case false:
                cell.isJumpLabel.text = "OFF"
            }
            switch isNoticeList[indexPath.row] {
            case true:
                cell.isNoticeLabel.text = "ON"
                
            case false:
                cell.isNoticeLabel.text = "OFF"
            }
            
            // 必ず書く
            return cell
        }
    }
    
    // 3.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(groupNameList.count == 0){
            let url = URL(string: "https://apps.apple.com/jp/app/%E5%B4%A9%E8%90%BD%E3%83%81%E3%82%A7%E3%82%B9/id1530379759")
            // iOS 10以降利用可能
            UIApplication.shared.open(url!)
        }
        else{
        tableView.deselectRow(at: indexPath, animated: true)
        
        groupNameG = groupNameList[indexPath.row]
        
        let query = NCMBQuery(className: "Group")
        query?.whereKey("groupName", equalTo: groupNameG)
        query?.findObjectsInBackground({ (result, error) in
            if(error != nil){
                // エラーが発生したら、
                print("error")
            }
            else{
                // 読み込みが成功したら、
                let messages = result as! [NCMBObject]
                let numOfMembers = messages[0].object(forKey: "numOfMembers") as! Int
                
                if( numOfMembers == 1 ) {
                    let message = messages[0]
                    message.setObject(numOfMembers + 1, forKey: "numOfMembers")
                    message.setObject(false, forKey: "isOpen")
                    message.saveInBackground({ (error) in
                        if(error != nil){
                            // エラーが発生したら、
                            print("error")
                        }
                        else{
                            // 保存が成功したら、
                            print("successed login")
                            self.goToNextPage()
                        }
                    })
                }
            }
        })
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
    func goToNextPage(){
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
                numOfMySide = messages[0].object(forKey: "numOfHostSide") as! Int
                numOfMySide = 3 - numOfMySide
                numOfShuffledArray = messages[0].object(forKey: "numOfShuffledArray") as! [Int]
                numOfGameMode = messages[0].object(forKey: "numOfGameMode") as! Int
                numOfPeriod = messages[0].object(forKey: "numOfPeriod") as! Int
                numOfTimeMode = messages[0].object(forKey: "numOfTimeMode") as! Int
                isSucide = messages[0].object(forKey: "isSucide") as! Bool
                isJump = messages[0].object(forKey: "isJump") as! Bool
                isNotice = messages[0].object(forKey: "isNotice") as! Bool
                self.performSegue(withIdentifier: "GameOnLine", sender: nil)
            }
        })
    }
    
    func load(){
        
        groupNameList.removeAll()
        numOfgameModeList.removeAll()
        periodList.removeAll()
        numOfgameModeList.removeAll()
        isSucideList.removeAll()
        isJumpList.removeAll()
        isNoticeList.removeAll()
        
        // データの取得
        let query = NCMBQuery(className: "Group")
        var memos = [NCMBObject]()
        query?.whereKey("isOpen", equalTo: true)
        query?.findObjectsInBackground({ (result, error) in
            if(error != nil){
                // エラーが発生したら、
                self.showAlertYT(titleYT: "エラー", textYT: error?.localizedDescription, buttonsYT: ["OK"], numOfmodeYT: 0)
            }
            else{
                // 読み込みが成功したら、
                memos = result as! [NCMBObject]
                
                for i in 0..<memos.count {
                    self.groupNameList.append(memos[i].object(forKey: "groupName") as! String)
                    self.numOfgameModeList.append(memos[i].object(forKey: "numOfGameMode") as! Int)
                    self.periodList.append(memos[i].object(forKey: "numOfPeriod") as! Int)
                    self.numOfTimeModeList.append(memos[i].object(forKey: "numOfTimeMode") as! Int)
                    self.isSucideList.append(memos[i].object(forKey: "isSucide") as! Bool)
                    self.isJumpList.append(memos[i].object(forKey: "isJump") as! Bool)
                    self.isNoticeList.append(memos[i].object(forKey: "isNotice") as! Bool)
                }
                self.tableView.reloadData()
            }
        })
    }
    
    @IBAction func reload(){
        load()
    }
    
    @IBAction func logIn(){
        if( groupNameTextField.text != nil && passwordTextField.text != nil ){
                
            let query = NCMBQuery(className: "Group")
            query?.whereKey("groupName", equalTo: groupNameTextField.text)
            query?.findObjectsInBackground({ (result, error) in
                if(error != nil){
                    // エラーが発生したら、
                    self.showAlertYT(titleYT: "エラー", textYT: error?.localizedDescription, buttonsYT: ["OK"], numOfmodeYT: 0)
                }
                else{
                    // 読み込みが成功したら、
                    let messages = result as! [NCMBObject]
                    if(messages.count == 0){
                        self.showAlertYT(titleYT: "エラー", textYT: "そのような部屋は存在しません。", buttonsYT: ["OK"], numOfmodeYT: 0)
                        self.groupNameTextField.text = ""
                    }
                    else{
                        let text = messages[0].object(forKey: "password") as! String
                        let numOfMembers = messages[0].object(forKey: "numOfMembers") as! Int
                        
                        if( self.passwordTextField.text == text && numOfMembers == 1 ) {
                            let message = messages[0]
                            message.setObject(numOfMembers + 1, forKey: "numOfMembers")
                            message.saveInBackground({ (error) in
                                if(error != nil){
                                    // エラーが発生したら、
                                    self.showAlertYT(titleYT: "エラー", textYT: error?.localizedDescription, buttonsYT: ["OK"], numOfmodeYT: 0)
                                }
                            })
                            
                            groupNameG = self.groupNameTextField.text!
                            self.goToNextPage()
                        }
                        else{
                            self.showAlertYT(titleYT: "エラー", textYT: "パスワードが違います。", buttonsYT: ["OK"], numOfmodeYT: 0)
                            self.passwordTextField.text = ""
                        }
                    }
                }
            })
        }
    }
    
}
