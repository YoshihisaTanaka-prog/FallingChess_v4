//
//  AlertFuncs.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/09/17.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func touryouAlert(_ side: Int){
        var text: String!
        switch numOfGameMode {
        case 0:
            switch side {
            case 1:
                text = "白が投了したので、黒の勝ちです。"
                break
                
            case 2:
                text = "黒が投了したので、白の勝ちです。"
                break
                
            default:
                break
            }
            break
            
        case 1:
            switch side {
            case 1:
                text = "先手が投了したので、後手の勝ちです。"
                break
                
            case 2:
                text = "後手が投了したので、先手の勝ちです。"
                break
                
            default:
                break
            }
            break
            
        case 2:
            switch side {
            case 1:
                text = "先手が投了したので、後手の勝ちです。"
                break
                
            case 2:
                text = "後手が投了したので、先手の勝ちです。"
                break
                
            default:
                break
            }
            break
            
        case 3:
            switch side {
            case 1:
                text = "先手が投了したので、後手の勝ちです。"
                break
                
            case 2:
                text = "後手が投了したので、先手の勝ちです。"
                break
                
            default:
                break
            }
            break
            
        default:
            break
        }
        self.showAlertYT(titleYT: "投了", textYT: text, buttonsYT: ["OK"], numOfmodeYT: 1)
    }
    
    //func continueOrQuitAlert(){
    //    if(isOnLine){
    //        showAlertQuickYT(titleYT: "継続", textYT: "ゲームを継続しますか？", buttonsYT: ["NO","YES"], numOfmodeYT: 3)
    //    }
    //    else{
    //        showAlertQuickYT(titleYT: "継続", textYT: "ゲームを継続しますか？", buttonsYT: ["NO","YES"], numOfmodeYT: 2)
    //    }
    //}
    
    func hougyoAlert(_ side: Int){
        var text: String!
        
        switch [numOfGameMode,side] {
        case [0,1]:
            text = "黒のキングが崩御したので、白の勝ちです。"
            break
            
        case [0,2]:
            text = "白のキングが崩御したので、黒の勝ちです。"
            break
            
        case [1,1]:
            text = "後手の王が崩御したので、先手の勝ちです。"
            break
            
        case [1,2]:
            text = "先手の玉が崩御したので、後手の勝ちです。"
            break
            
        default:
            return
        }
        
        //アラートの表示
        self.showAlertQuickYT(titleYT: "崩御", textYT: text, buttonsYT: ["OK"], numOfmodeYT: 4)
    }
    
    func timeOutAlert(_ side: Int){
        var text: String!
        
        switch [numOfGameMode,side] {
        case [0,1]:
            text = "黒が時間を使い切ったので、白の勝ちです。"
            break
            
        case [0,2]:
            text = "白が時間を使い切ったので、黒の勝ちです。"
            break
            
        case [1,1]:
            text = "後手が時間を使い切ったので、先手の勝ちです。"
            break
            
        case [1,2]:
            text = "先手が時間を使い切ったので、後手の勝ちです。"
            break
            
        default:
            return
        }
        
        //アラートの表示
        self.showAlertQuickYT(titleYT: "時間切れ", textYT: text, buttonsYT: ["OK"], numOfmodeYT: 5)
    }
    
    func checkedAlert(){
        var oute: String!
        var text: String!
        switch numOfGameMode {
        case 0:
            oute = "チェック"
            text = "チェック！"
            break
            
        case 1:
            oute = "王手"
            text = "王手！"
            break
            
        default:
            break
        }
        
        self.showAlertQuickYT(titleYT: oute, textYT: text, buttonsYT: ["OK"], numOfmodeYT: 6)
    }
    
    func checkmateAlert(_ side: Int){
        var title: String!
        var text: String!
        switch [numOfGameMode,side] {
        case [0,1]:
            title = "チェックメイト"
            text = "チェックメイトです。白の勝ちです。"
            break
            
        case [0,2]:
            title = "チェックメイト"
            text = "チェックメイトです。黒の勝ちです。"
            break
            
        case [1,1]:
            title = "詰み"
            text = "詰みです。先手の勝ちです。"
            break
            
        case [1,2]:
            title = "詰み"
            text = "詰みです。後手の勝ちです。"
            break
            
        default:
            return
        }
        
        self.showAlertQuickYT(titleYT: title, textYT: text, buttonsYT: ["OK"], numOfmodeYT: 7)
    }
    
    func stalemateAlert(){
        self.showAlertQuickYT(titleYT: "ステイルメイト", textYT: "引き分けです。", buttonsYT: ["OK"], numOfmodeYT: 8)
    }
    
    func utihudumeAlert(){
        self.showAlertQuickYT(titleYT: "詰み", textYT: "打ち歩詰めです。", buttonsYT: ["OK"], numOfmodeYT: 9)
    }
    
    func holeAlert(){
        var text: String!
        
        if( isNotice && numOfTurn % numOfPeriod == numOfWhenAlertG ){
            text = banchiG[numOfShuffledArray[ numOfTurn / numOfPeriod ]] + "が崩落します。"
            showAlertQuickYT(titleYT: "崩落", textYT: text,buttonsYT: ["OK"], numOfmodeYT: 0)
            print( [banchiG[numOfShuffledArray[ numOfTurn / numOfPeriod ]] , numOfShuffledArray[ numOfTurn / numOfPeriod ] ])
        }
        if( numOfTurn % numOfPeriod == 0 ){
            text = banchiG[numOfShuffledArray[ numOfTurn / numOfPeriod - 1]] + "が崩落しました。"
            showAlertQuickYT(titleYT: "崩落", textYT: text,buttonsYT: ["OK"], numOfmodeYT: 0)
            print( [banchiG[numOfShuffledArray[ numOfTurn / numOfPeriod - 1]] , numOfShuffledArray[ numOfTurn / numOfPeriod ] - 1])
        }
    }
    
    func promotionAlert(){
        isNotSellectingPromotionG = false
        switch numOfGameMode {
        case 0:
            self.showAlertActionSheetQuickYT(titleYT: "プロモーション", textYT: "どの駒に成りますか？", buttonsYT: ["クイーン","ビショップ","ナイト","ルーク"], numOfmodeYT: 10)
            break
            
        case 1:
            self.showAlertActionSheetQuickYT(titleYT: "成り", textYT: "成りますか？", buttonsYT: ["YES","NO"], numOfmodeYT: 11)
            break
            
        case 2:
            break
            
        case 3:
            break
            
        default:
            break
        }
    }
    
    //func thousandAlert(_ side : Int){
    //    switch side {
    //    case 1:
    //        break
    //
    //    case 2:
    //        break
    //
    //    default:
    //        break
    //    }
    //    showAlertYT(titleYT: "千日手", textYT: "", buttonsYT: ["OK"], numOfmodeYT: 12)
    //}
}
