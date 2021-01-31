//
//  SetRulesViewController.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/08/17.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import UIKit

class SetRulesViewController: UIViewController {
    
    var screenArray: [Screen] = []
    var titleArray: [String] = ["飛び込み可","飛び越え可","事前通達"]
    var explainArray: [String] = ["この設定をオンにすることで駒が自ら飛び込むことができるようになります。","この設定をオンにすることでルークや角行などの複数マス進める駒が穴を飛び越えられるようになります。","この設定をオンにすることでどのマスが崩落するのか二手前に通達されるようになります。崩落頻度が1の場合は設定できません。"]
    var boolArray: [Bool] = [isSucide,isJump,isNotice]
    
    //UIScrollViewのインスタンス作成
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.makeBackGround(isExistsNaviBar: true, isExistsTabBar: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //scrollViewの大きさを設定。
        scrollView.frame = self.view.frame
        
        //スクロール領域の設定
        scrollView.contentSize = CGSize(width: self.view.frame.width, height:1000)
        scrollView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        
        //scrollViewをviewのSubViewとして追加
        self.view.addSubview(scrollView)
        for i in 0..<3 {
            add(i:i)
        }
        for subView in scrollView.subviews{
            subView.alpha = numOfButtonAlpha.f
        }
    }
    
    func add(i: Int){
        // タイトル
        let label = UILabel()
        label.frame = CGRect(x: 40, y: 40 + i * 320, width: 155, height: 40) // 位置とサイズの指定
        label.textColor = UIColor.black // テキストカラーの設定
        label.font = UIFont(name: "HiraKakuProN-W6", size: 30) // フォントの設定
        label.text = titleArray[i]
        label.backgroundColor = UIColor.white
        scrollView.addSubview(label)
        
        // スイッチ
        let swith = UISwitch(frame: CGRect(x: Int(UIScreen.main.bounds.size.width) - 89, y: 45 + i * 320 , width: 50, height: 30))
        // UISwitch値が変更された時に呼び出すメソッドの設定
        swith.addTarget(self, action: #selector(changeSwitch), for: UIControl.Event.valueChanged)
        // UISwitchの状態をオンに設定
        swith.isOn = boolArray[i]
        swith.tag = i
        swith.backgroundColor = UIColor.white
        // UISwitchを追加
        scrollView.addSubview(swith)
        
        // 説明
        let explain = UITextView()
        explain.frame = CGRect(x: 50, y: 120 + i * 320, width: Int(UIScreen.main.bounds.size.width) - 100, height: 160) // 位置とサイズの指定
        explain.textColor = UIColor.black // テキストカラーの設定
        explain.textAlignment = NSTextAlignment.center // 横揃えの設定
        explain.font = UIFont(name: "HiraKakuProN-W6", size: 20) // フォントの設定
        explain.text = explainArray[i]
        explain.isEditable = false
        explain.backgroundColor = UIColor(red: 1, green: 1, blue: 0.9, alpha: 1)
        explain.isSelectable = false
        scrollView.addSubview(explain)
        
        screenArray.append(Screen(title: label, swith: swith, explain: explain))
        
    }
    @objc func changeSwitch(sender: UISwitch){
        switch sender.tag {
        case 0:
            let ud = UserDefaults.standard
            if sender.isOn{
                ud.set(true,forKey: "isSucide")
                isSucide = true
            }
            else{
                ud.set(false, forKey: "isSucide")
                isSucide = false
            }
            ud.synchronize()
            break
            
        case 1:
            let ud = UserDefaults.standard
            if sender.isOn{
                ud.set(true,forKey: "isJump")
                isJump = true
            }
            else{
                ud.set(false, forKey: "isJump")
                isJump = false
            }
            ud.synchronize()
            break
            
        case 2:
            let ud = UserDefaults.standard
            if sender.isOn{
                if( numOfPeriod != 1 ){
                    ud.set(true,forKey: "isNotice")
                    isNotice = true
                }
                else{
                    screenArray[2].swith.setOn(false, animated: true)
                    showAlert()
                }
            }
            else{
                ud.set(false, forKey: "isNotice")
                isNotice = false
            }
            ud.synchronize()
            break
            
        default:
            break
        }
    }
    
    // alertの設定
    func showAlert(){
        //アラートの表示
        let alertController = UIAlertController(title: "注意", message: "崩落頻度が1の場合は事前通達できません。", preferredStyle: .alert)
        let alertOkAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // OKボタンを押した後のアクション
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertOkAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

class Screen: NSObject{
    var title: UILabel
    var swith: UISwitch
    var explain: UITextView
    init(title: UILabel, swith: UISwitch, explain: UITextView) {
        self.title = title
        self.swith = swith
        self.explain = explain
    }
}
