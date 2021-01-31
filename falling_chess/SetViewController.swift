//
//  SetViewController.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/08/17.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {
    
    var screenButtonArray: [OriginalButton] = []
    
    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.makeBackGround(isExistsNaviBar: true, isExistsTabBar: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let size: CGFloat = max(300.f, self.view.layer.frame.size.width / 2.f) * 2 / 7
        
        //scrollViewの大きさを設定。
        scrollView.frame = self.view.frame
        scrollView.center = CGPoint(x: self.view.frame.width / 2, y: scrollView.frame.size.height / 2 + cgOfTopMarginListG[1])
        
        //スクロール領域の設定
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: size * 12)
        scrollView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        
        //scrollViewをviewのSubViewとして追加
        self.view.addSubview(scrollView)
        
        // ボタンの生成
        createButtonArray(titles: ["ゲームの種類","崩落頻度","持ち時間","ルール","デザインなど"], size: size)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        for button in screenButtonArray {
            button.removeFromSuperview()
        }
        screenButtonArray.removeAll()
        scrollView.removeFromSuperview()
    }
    
    func createButtonArray(titles: [String], size: CGFloat){
        for i in 0..<titles.count{
            let button = OriginalButton(type: UIButton.ButtonType.system)
            button.makeButton(size: size, titles: titles, num: i)
            button.alpha = numOfButtonAlpha.f
            button.addTarget(self, action: #selector(buttonEvent(_:)), for: UIControl.Event.touchUpInside)
            button.tag = i
            //             viewに追加する
            scrollView.addSubview(button)
            screenButtonArray.append(button)
        }
    }
    
    @objc func buttonEvent(_ sender: UIButton){
        switch sender.tag {
        case 0:
            self.performSegue(withIdentifier: "Kind", sender: nil)
            break
            
        case 1:
            self.performSegue(withIdentifier: "Period", sender: nil)
            break
            
        case 2:
            self.performSegue(withIdentifier: "Time", sender: nil)
            break
            
        case 3:
            self.performSegue(withIdentifier: "Rules", sender: nil)
            break
            
        case 4:
            self.performSegue(withIdentifier: "Design", sender: nil)
            break
            
        default:
            break
        }
    }
}
