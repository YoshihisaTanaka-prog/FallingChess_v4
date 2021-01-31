//
//  HowToUseContentsViewController.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/10/01.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import UIKit

class HowToUseContentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var num: Int = 0
    
    let titleArray: [String] = ["","部屋の作り方(ホスト)","","公開部屋への入り方(ゲスト)","","秘密部屋への入り方(ゲスト)"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        cell.textLabel?.text = titleArray[indexPath.row]
        
        cell.textLabel?.textAlignment = NSTextAlignment.center
        
        if(indexPath.row % 2 == 0){
            cell.backgroundColor = .clear
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        num = indexPath.row
        if( num % 2 == 1 ){
            num = num / 2
            self.performSegue(withIdentifier: "detail", sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        UITabBar.appearance().backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        tableView.alpha = numOfButtonAlpha.f
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.makeBackGround(isExistsNaviBar: true, isExistsTabBar: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // データ・ソースメソッドをこのファイル内で処理しますよ。
        tableView.dataSource = self
        // デリゲートメソッドをselfに任せる
        tableView.delegate = self
        // セルの幅を指定
        tableView.rowHeight = 75
        // TableViewの不要な線を消すためのコード
        tableView.tableFooterView = UIView()
        
        tableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 値を渡すコード
        // 次の画面を取得
        let View2 = segue.destination as! HowToUseLogInViewController
        View2.passedNum = num
    }

}
