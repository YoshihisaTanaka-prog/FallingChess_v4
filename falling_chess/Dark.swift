//
//  Dark.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/10/15.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import Foundation
import UIKit

class DarkView: UIView{
    
    func showThinkingChild(isRotate: Bool, mySide: Int){
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        if isRotate {
            self.transform = self.transform.rotated(by: CGFloat(Double.pi))
        }
        let label = UILabel()
        label.frame = CGRect(x: (self.frame.width - 300) / 2, y: (self.frame.height - 250) / 2, width: 300, height: 250)
        label.layer.cornerRadius = 10
        label.textColor = UIColor.black // テキストカラーの設定
        label.font = UIFont(name: "HiraKakuProN-W6", size: 30) // フォントの設定
        label.numberOfLines = 0
        label.backgroundColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.alpha = 0.5
        
        switch [numOfGameMode,mySide] {
        case [0,1]:
            label.text = "黒が考え中です。しばらくお待ちください。"
            break
            
        case [0,2]:
            label.text = "白が考え中です。しばらくお待ちください。"
            break
            
        case [1,1]:
            label.text = "後手が考え中です。しばらくお待ちください。"
            break
            
        case [1,2]:
            label.text = "先手が考え中です。しばらくお待ちください。"
            break
            
        default:
            break
        }
        
        self.addSubview(label)
        self.sendSubviewToBack(label)
    }
    
    func promotionSelect(_ turn: Int){
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        if( turn % 2 == 0 && !isOnLine ){
            self.transform = self.transform.rotated(by: CGFloat(Double.pi))
        }
        
        let view = UIView()
        let label = UILabel()
        var buttons = [UIButton]()
        
        
        switch numOfGameMode {
        case 0:
            view.frame = CGRect(x: (self.frame.width - 300) / 2, y: (self.frame.height - 350) / 2, width: 300, height: 350)
            view.layer.cornerRadius = 10
            if(turn % 2 == 0){
                view.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 1, alpha: 1)
            }
            else{
                view.backgroundColor = UIColor(red: 1, green: 0.8, blue: 0.8, alpha: 1)
            }
            self.addSubview(view)
            
            label.frame = CGRect(x: 20, y: 40, width: 260, height: 50)
            label.text = "プロモーション！どれにしますか？"
            label.textColor = UIColor.black // テキストカラーの設定
            label.textAlignment = NSTextAlignment.center
            view.addSubview(label)
            
            let title = ["クイーン","ビショップ","ナイト","ルーク"]
            for i in 0..<4{
                buttons.append(UIButton())
                buttons[i].frame = CGRect(x: 20, y: 130 + 50 * i, width: 260, height: 40)
                buttons[i].backgroundColor = UIColor(red: 1, green: 1, blue: 0.8, alpha: 1)
                buttons[i].setTitleColor(.black, for: .normal)
                buttons[i].tag = i
                buttons[i].addTarget(self, action: #selector(buttonEvent(_:)), for: .touchUpInside)
                buttons[i].setTitle(title[i], for: UIControl.State.normal)
            }
            
            
            break
            
        case 1:
            view.frame = CGRect(x: (self.frame.width - 300) / 2, y: (self.frame.height - 250) / 2, width: 300, height: 250)
            view.layer.cornerRadius = 10
            if(turn % 2 == 0){
                view.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 1, alpha: 1)
            }
            else{
                view.backgroundColor = UIColor(red: 1, green: 0.8, blue: 0.8, alpha: 1)
            }
            self.addSubview(view)
            
            label.frame = CGRect(x: 20, y: 40, width: 260, height: 50)
            label.text = "成りますか？"
            label.textColor = UIColor.black // テキストカラーの設定
            view.addSubview(label)
            
            let title = ["はい","いいえ"]
            for i in 0..<2{
                buttons.append(UIButton())
                buttons[i].frame = CGRect(x: 20, y: 130 + 50 * i, width: 260, height: 40)
                buttons[i].backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
                buttons[i].setTitleColor(.black, for: .normal)
                buttons[i].tag = i
                buttons[i].addTarget(self, action: #selector(buttonEvent(_:)), for: .touchUpInside)
                buttons[i].setTitle(title[i], for: UIControl.State.normal)
            }
            break
            
        default:
            break
        }
        for button in buttons {
            view.addSubview(button)
        }
    }
    
    @objc func buttonEvent(_ sender: UIButton){
        switch [numOfGameMode,sender.tag]{
        case [0,0]:
            if(statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA != 30){
                statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA = statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA + 4
            }
            break
            
        case [0,1]:
            if(statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA != 30){
                statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA = statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA + 3
            }
            break
            
        case [0,2]:
            if(statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA != 30){
                statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA = statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA + 2            }
            break
            
        case [0,3]:
            if(statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA != 30){
                statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA = statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA + 1
            }
            break
            
        case [1,0]:
            if(statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA != 30){
                statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA = statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA + 10
            }
            break
            
        case [1,1]:
            break
            
        default:
            break
        }
        isNotSellectingPromotionG = true
        self.removeFromSuperview()
    }
}
