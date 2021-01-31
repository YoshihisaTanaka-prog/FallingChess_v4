//
//  ChessFuncs.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/08/17.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func checkChess(side: Int, placeX: Int, placeY: Int, isValueOfAlly: Bool) -> Bool{
        let numberOfEnemyRangeMin: Int = ( 3 - side ) * 20 + 100
        let numberOfEnemyRangeMax: Int = ( 3 - side ) * 20 + 119
        let numberOfAllyRangeMin: Int = side * 20 + 100
        let numberOfAllyRangeMax: Int = side * 20 + 119
        var checkPlaceY: Int = 0
        
        switch side {
        case 1:
            checkPlaceY = 2
            break
            
        case 2:
            checkPlaceY = 5
            break
            
        default:
            break
        }
        
        // 行き先がボードの外になるとき
        if( placeX < 0 || placeX >= numOfSquare || placeY < 0 || placeY >= numOfSquare ){        return false
        }
            // 味方がいるとき
        else if( statusArrayG[placeY][placeX].nOPA > numberOfAllyRangeMin && statusArrayG[placeY][placeX].nOPA < numberOfAllyRangeMax ){
            
            if (!isNegative && isValueOfAlly) || (isNegative && !isValueOfAlly) {
                statusArrayG[placeY][placeX].iATM = true
            }
            else{
                statusArrayG[placeY][placeX].iATM = false
            }
            return false
        }
            // 穴が空いているとき
        else if( statusArrayG[placeY][placeX].nOPA == 30 ){
            // 自ら穴に落ちることができる時の処理
            if( isSucide == true && statusArrayG[placeY][placeX].nOPA % 20 != 8 ){
                // pornが斜めに進むときは敵がいないと動けない
                if( statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA % 20 == 1 && numberOfPlaceX != placeX ){
                    return false
                }
                else{
                    // (placeX,placeY)が移動可能であるとみなす。
                    if(isNegative){
                        statusArrayG[placeY][placeX].iATM = false
                        buttonArray[placeY][placeX].backgroundColor =  colorArray[placeY][placeX]
                    }
                    else{
                        statusArrayG[placeY][placeX].iATM = true
                        buttonArray[placeY][placeX].backgroundColor = colorOfEnableToMovePlace[side - 1][placeY][placeX]
                    }
                }
            }
            if(isJump){
                return true
            }
            else{
                return false
            }
        }
            // 敵がいるとき
        else if( statusArrayG[placeY][placeX].nOPA > numberOfEnemyRangeMin && statusArrayG[placeY][placeX].nOPA < numberOfEnemyRangeMax ){
            // pornの処理
            if( statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA % 20 == 1 && numberOfPlaceX == placeX ){
                return false
            }
            else{
                // (placeX,placeY)が移動可能であるとみなす。
                if(isNegative){
                    statusArrayG[placeY][placeX].iATM = false
                    buttonArray[placeY][placeX].backgroundColor =  colorArray[placeY][placeX]
                }
                else{
                    statusArrayG[placeY][placeX].iATM = true
                    buttonArray[placeY][placeX].backgroundColor = colorOfEnableToMovePlace[side - 1][placeY][placeX]
                }
                return false
            }
        }
            // 空白のとき
        else{
            // pornが斜めに進むときは敵がいないと基本的に動けない
            if( statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA % 20 == 1 && numberOfPlaceX != placeX ){
                // アンパッサンの時は動ける。
                if( numOfEnPassant == placeX && placeY == checkPlaceY ){
                    if(isNegative){
                        statusArrayG[placeY][placeX].iATM = false
                        buttonArray[placeY][placeX].backgroundColor =  colorArray[placeY][placeX]
                    }
                    else{
                        statusArrayG[placeY][placeX].iATM = true
                        buttonArray[placeY][placeX].backgroundColor = colorOfEnableToMovePlace[side - 1][placeY][placeX]
                    }
                    return true
                }
                else{
                    return false
                }
            }
            else{
                // (placeX,placeY)が移動可能であるとみなす。
                if(isNegative){
                    statusArrayG[placeY][placeX].iATM = false
                    buttonArray[placeY][placeX].backgroundColor =  colorArray[placeY][placeX]
                }
                else{
                    statusArrayG[placeY][placeX].iATM = true
                    // キャスリングの時だけ色を変える
                    if( statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA % 20 == 8 && ( placeX - numberOfPlaceX == 2 || placeX - numberOfPlaceX == -2 ) ){
                        buttonArray[placeY][placeX].backgroundColor = UIColor(red:0,green:1,blue:0,alpha:1)
                    }
                    else{
                        buttonArray[placeY][placeX].backgroundColor = colorOfEnableToMovePlace[side - 1][placeY][placeX]
                    }
                }
                return true
            }
        }
    }
    
    func checkChessVoid(side: Int, placeX: Int, placeY: Int, isValueOfAlly: Bool){
        let numberOfEnemyRangeMin: Int = ( 3 - side ) * 20 + 100
        let numberOfEnemyRangeMax: Int = ( 3 - side ) * 20 + 119
        let numberOfAllyRangeMin: Int = side * 20 + 100
        let numberOfAllyRangeMax: Int = side * 20 + 119
        
        // 行き先がボードの外になるとき
        if( placeX < 0 || placeX >= numOfSquare || placeY < 0 || placeY >= numOfSquare ){}
            // 味方がいるとき
        else if( statusArrayG[placeY][placeX].nOPA > numberOfAllyRangeMin && statusArrayG[placeY][placeX].nOPA < numberOfAllyRangeMax ){
            
            if (!isNegative && isValueOfAlly) || (isNegative && !isValueOfAlly) {
                statusArrayG[placeY][placeX].iATM = true
            }
            else{
                statusArrayG[placeY][placeX].iATM = false
            }
        }
            // 穴が空いているとき
        else if( statusArrayG[placeY][placeX].nOPA == 30 && statusArrayG[placeY][placeX].nOPA % 20 != 8 ){
            // 自ら穴に落ちることができる時の処理
            if( isSucide == true ){
                // pornが斜めに進むときは敵がいないと動けない
                if( statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA % 20 == 1 && numberOfPlaceX != placeX ){
                }
                else{
                    // (placeX,placeY)が移動可能であるとみなす。
                    if(isNegative){
                        statusArrayG[placeY][placeX].iATM = false
                        buttonArray[placeY][placeX].backgroundColor =  colorArray[placeY][placeX]
                    }
                    else{
                        statusArrayG[placeY][placeX].iATM = true
                        buttonArray[placeY][placeX].backgroundColor = colorOfEnableToMovePlace[side - 1][placeY][placeX]
                    }
                }
            }
        }
            // 敵がいるとき
        else if( statusArrayG[placeY][placeX].nOPA > numberOfEnemyRangeMin && statusArrayG[placeY][placeX].nOPA < numberOfEnemyRangeMax ){
            // pornの処理
            if( statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA % 20 == 1 && numberOfPlaceX == placeX ){}
            else{
                // (placeX,placeY)が移動可能であるとみなす。
                if(isNegative){
                    statusArrayG[placeY][placeX].iATM = false
                    buttonArray[placeY][placeX].backgroundColor =  colorArray[placeY][placeX]
                }
                else{
                    statusArrayG[placeY][placeX].iATM = true
                    buttonArray[placeY][placeX].backgroundColor = colorOfEnableToMovePlace[side - 1][placeY][placeX]
                }
            }
        }
            // 空白のとき
        else{
            // pornが斜めに進むときは敵がいないと基本的に動けない
            if( statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA % 20 == 1 && numberOfPlaceX != placeX ){
                // アンパッサンの時は動ける。
                if( numOfEnPassant == numberOfPlaceNextX ){}
            }
            else{
                // (placeX,placeY)が移動可能であるとみなす。
                if(isNegative){
                    statusArrayG[placeY][placeX].iATM = false
                    buttonArray[placeY][placeX].backgroundColor =  colorArray[placeY][placeX]
                }
                else{
                    statusArrayG[placeY][placeX].iATM = true
                    // キャスリングの時だけ色を変える
                    if( statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA % 20 == 8 && ( placeX - numberOfPlaceX == 2 || placeX - numberOfPlaceX == -2 ) ){
                        buttonArray[placeY][placeX].backgroundColor = UIColor(red:0,green:1,blue:0,alpha:1)
                    }
                    else{
                        buttonArray[placeY][placeX].backgroundColor = colorOfEnableToMovePlace[side - 1][placeY][placeX]
                    }
                }
            }
        }
    }
    
    
    func moveOfPorn(side: Int, isValueOfAlly: Bool){
        var pm: Int = 0
        var firstY: Int = 0
        switch side {
        case 1:
            pm = 1
            firstY = 6
            break
            
        case 2:
            pm = -1
            firstY = 1
            break
            
        default:
            break
        }
        
        if( isAbleToMoveChess(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 1) ){
            if( checkChess(side: side, placeX: numberOfPlaceX, placeY: numberOfPlaceY - pm, isValueOfAlly: isValueOfAlly) == true ){
                print("Can go to [" + String(numberOfPlaceX) + String(numberOfPlaceY - pm) + "]")
                if( numberOfPlaceY == firstY ){
                    if( checkChess(side: side, placeX: numberOfPlaceX, placeY: numberOfPlaceY - 2 * pm, isValueOfAlly: isValueOfAlly) == true ){
                        print("Can go to [" + String(numberOfPlaceX) + String(numberOfPlaceY - 2 * pm) + "]")
                        
                    }
                }
            }
        }
        if( isAbleToMoveChess(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 2) ){
            if( checkChess(side: side, placeX: numberOfPlaceX + pm, placeY: numberOfPlaceY - pm, isValueOfAlly: isValueOfAlly) == true ){
                print("Can go to [" + String(numberOfPlaceX + pm) + String(numberOfPlaceY - pm) + "]")
            }
        }
        if( isAbleToMoveChess(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 4) ){
            if( checkChess(side: side, placeX: numberOfPlaceX - pm, placeY: numberOfPlaceY - pm, isValueOfAlly: isValueOfAlly) == true ){
                print("Can go to [" + String(numberOfPlaceX - pm) + String(numberOfPlaceY - pm) + "]")
            }
        }
    }
    func moveOfRook(side: Int, isValueOfAlly: Bool){
        var pm: Int = 0
        switch side {
        case 1:
            pm = 1
            break
            
        case 2:
            pm = -1
            break
            
        default:
            break
        }
        var numI: Int = pm
        if( isAbleToMoveChess(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 3) ){
            // 右方向
            while checkChess(side: side, placeX: numberOfPlaceX + numI, placeY: numberOfPlaceY, isValueOfAlly: isValueOfAlly) == true {
                numI = numI + pm
            }
            // 左方向
            numI = pm
            while checkChess(side: side, placeX: numberOfPlaceX - numI, placeY: numberOfPlaceY, isValueOfAlly: isValueOfAlly) == true {
                numI = numI + pm
            }
        }
        if( isAbleToMoveChess(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 1 ) ){
            // 下方向
            numI = pm
            while checkChess(side: side, placeX: numberOfPlaceX, placeY: numberOfPlaceY + numI, isValueOfAlly: isValueOfAlly) == true {
                numI = numI + pm
            }
            // 上方向
            numI = pm
            while checkChess(side: side, placeX: numberOfPlaceX, placeY: numberOfPlaceY - numI, isValueOfAlly: isValueOfAlly) == true {
                numI = numI + pm
            }
        }
    }
    func moveOfKnight(side: Int, isValueOfAlly: Bool){
        var pm: Int = 0
        switch side {
        case 1:
            pm = 1
            break
            
        case 2:
            pm = -1
            break
            
        default:
            break
        }
        if( isAbleToMoveChess(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 1) &&
            isAbleToMoveChess(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 2) &&
            isAbleToMoveChess(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 3) &&
            isAbleToMoveChess(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 4) ){
            checkChessVoid(side: side, placeX: numberOfPlaceX + 2*pm, placeY: numberOfPlaceY + pm, isValueOfAlly: isValueOfAlly)
            checkChessVoid(side: side, placeX: numberOfPlaceX + pm, placeY: numberOfPlaceY + 2*pm, isValueOfAlly: isValueOfAlly)
            checkChessVoid(side: side, placeX: numberOfPlaceX + 2*pm, placeY: numberOfPlaceY - pm, isValueOfAlly: isValueOfAlly)
            checkChessVoid(side: side, placeX: numberOfPlaceX + pm, placeY: numberOfPlaceY - 2*pm, isValueOfAlly: isValueOfAlly)
            checkChessVoid(side: side, placeX: numberOfPlaceX - 2*pm, placeY: numberOfPlaceY + pm, isValueOfAlly: isValueOfAlly)
            checkChessVoid(side: side, placeX: numberOfPlaceX - pm, placeY: numberOfPlaceY + 2*pm, isValueOfAlly: isValueOfAlly)
            checkChessVoid(side: side, placeX: numberOfPlaceX - 2*pm, placeY: numberOfPlaceY - pm, isValueOfAlly: isValueOfAlly)
            checkChessVoid(side: side, placeX: numberOfPlaceX - pm, placeY: numberOfPlaceY - 2*pm, isValueOfAlly: isValueOfAlly)
        }
    }
    func moveOfBishop(side: Int, isValueOfAlly: Bool){
        var pm: Int = 0
        switch side {
        case 1:
            pm = 1
            break
            
        case 2:
            pm = -1
            break
            
        default:
            break
        }
        var numI: Int = pm
        if( isAbleToMoveChess(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 4) ){
            // 右下方向
            while checkChess(side: side, placeX: numberOfPlaceX + numI, placeY: numberOfPlaceY + numI, isValueOfAlly: isValueOfAlly) == true {
                numI = numI + pm
            }
            // 左上方向
            numI = pm
            while checkChess(side: side, placeX: numberOfPlaceX - numI, placeY: numberOfPlaceY - numI, isValueOfAlly: isValueOfAlly) == true {
                numI = numI + pm
            }
        }
        if( isAbleToMoveChess(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 2) ){
            // 左下方向
            numI = pm
            while checkChess(side: side, placeX: numberOfPlaceX - numI, placeY: numberOfPlaceY + numI, isValueOfAlly: isValueOfAlly) == true {
                numI = numI + pm
            }
            // 右上方向
            numI = pm
            while checkChess(side: side, placeX: numberOfPlaceX + numI, placeY: numberOfPlaceY - numI, isValueOfAlly: isValueOfAlly) == true {
                numI = numI + pm
            }
        }
    }
    
    func moveOfKing(side: Int, isValueOfAlly: Bool){
        var pm: Int = 0
        switch side {
        case 1:
            pm = 1
            break
            
        case 2:
            pm = -1
            break
            
        default:
            break
        }
        checkChessVoid(side: side, placeX: numberOfPlaceX, placeY: numberOfPlaceY - pm, isValueOfAlly: isValueOfAlly)
        checkChessVoid(side: side, placeX: numberOfPlaceX + pm, placeY: numberOfPlaceY - pm, isValueOfAlly: isValueOfAlly)
        if( checkChess(side: side, placeX: numberOfPlaceX + pm, placeY: numberOfPlaceY, isValueOfAlly: isValueOfAlly) ){
            switch side {
            case 1:
                if( abilityOfCastlingWhiteRight && statusArrayG[numberOfPlaceY][numberOfPlaceX - pm].nOPA == 0 && 0 <= numberOfPlaceX + 2*pm && numberOfPlaceX + 2*pm < 8 ){
                    if(statusArrayG[numberOfPlaceY][numberOfPlaceX + 2*pm].nOPA == 0){
                        checkChessVoid(side: side, placeX: numberOfPlaceX + 2*pm, placeY: numberOfPlaceY, isValueOfAlly: isValueOfAlly)
                    }
                }
                break
                
            case 2:
                if( abilityOfCastlingBlackLeft && ( statusArrayG[0][1].nOPA == 0 || (statusArrayG[0][1].nOPA == 30 && isJump ) ) && statusArrayG[numberOfPlaceY][numberOfPlaceX - pm].nOPA == 0 && 0 <= numberOfPlaceX + 2*pm && numberOfPlaceX + 2*pm < 8 ){
                    if(statusArrayG[numberOfPlaceY][numberOfPlaceX + 2*pm].nOPA == 0){
                        checkChessVoid(side: side, placeX: numberOfPlaceX + 2*pm, placeY: numberOfPlaceY, isValueOfAlly: isValueOfAlly)
                    }
                }
                break
                
            default:
                break
            }
            
        }
        checkChessVoid(side: side, placeX: numberOfPlaceX + pm, placeY: numberOfPlaceY + pm, isValueOfAlly: isValueOfAlly)
        checkChessVoid(side: side, placeX: numberOfPlaceX, placeY: numberOfPlaceY + pm, isValueOfAlly: isValueOfAlly)
        checkChessVoid(side: side, placeX: numberOfPlaceX - pm, placeY: numberOfPlaceY + pm, isValueOfAlly: isValueOfAlly)
        if( checkChess(side: side, placeX: numberOfPlaceX - pm, placeY: numberOfPlaceY, isValueOfAlly: isValueOfAlly) ){
            switch side {
            case 1:
                if( abilityOfCastlingWhiteLeft && ( statusArrayG[7][1].nOPA == 0 || (statusArrayG[7][1].nOPA == 30 && isJump ) ) && statusArrayG[numberOfPlaceY][numberOfPlaceX - pm].nOPA == 0 && 0 <= numberOfPlaceX - 2*pm && numberOfPlaceX - 2*pm < 8 ){
                    if(statusArrayG[numberOfPlaceY][numberOfPlaceX - 2*pm].nOPA == 0){
                        checkChessVoid(side: side, placeX: numberOfPlaceX - 2 * pm, placeY: numberOfPlaceY, isValueOfAlly: isValueOfAlly)
                    }
                }
                break
                
            case 2:
                if( abilityOfCastlingBlackRight && statusArrayG[numberOfPlaceY][numberOfPlaceX - pm].nOPA == 0 && 0 <= numberOfPlaceX - 2*pm && numberOfPlaceX - 2*pm < 8 ){
                    if(statusArrayG[numberOfPlaceY][numberOfPlaceX - 2*pm].nOPA == 0){
                        checkChessVoid(side: side, placeX: numberOfPlaceX - 2 * pm, placeY: numberOfPlaceY, isValueOfAlly: isValueOfAlly)
                    }
                }
                break
                
            default:
                break
            }
            
        }
        checkChessVoid(side: side, placeX: numberOfPlaceX - pm, placeY: numberOfPlaceY - pm, isValueOfAlly: isValueOfAlly)
        for i in 0..<numOfSquare {
            for j in 0..<numOfSquare {
                if( statusArrayG[i][j].iEATA ){
                    statusArrayG[i][j].iATM = false
                    buttonArray[i][j].backgroundColor = colorArray[i][j]
                }
            }
        }
        if(numberOfPlaceX == 4){
            if( !statusArrayG[numberOfPlaceY][5].iATM || statusArrayG[numberOfPlaceY][6].nOPA != 0 ){
                statusArrayG[numberOfPlaceY][6].iATM = false
                buttonArray[numberOfPlaceY][6].backgroundColor = colorArray[numberOfPlaceY][6]
            }
            if( !statusArrayG[numberOfPlaceY][3].iATM || statusArrayG[numberOfPlaceY][2].nOPA != 0 ){
                statusArrayG[numberOfPlaceY][2].iATM = false
                buttonArray[numberOfPlaceY][2].backgroundColor = colorArray[numberOfPlaceY][2]
            }
        }
    }
    
    func moveChess(side: Int) ->Bool{
        var ret:Bool = false
        var pm: Int = 0
        let nOPA: Int = statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA
        let numOfCheckY: Int = numberOfPlaceY
        let numOfCheckNextY: Int = numberOfPlaceNextY
        let numberOfNextSteats: Int = statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA
        let numOfAllyPorn: Int = 101 + side * 20
        
        switch side {
        case 1:
            pm = 1
            break
            
        case 2:
            pm = -1
            break
            
        default:
            break
        }
        
        // キング一度でも動いたらキャスリングできなくなる。
        if( (numberOfPlaceY == 7 && numberOfPlaceX == 4 ) || (numberOfPlaceNextY == 7 && numberOfPlaceNextX == 4 ) ){
            abilityOfCastlingWhiteLeft = false
            abilityOfCastlingWhiteRight = false
        }
        if( (numberOfPlaceY == 0 && numberOfPlaceX == 4 ) || (numberOfPlaceNextY == 0 && numberOfPlaceNextX == 4 ) ){
            abilityOfCastlingBlackLeft = false
            abilityOfCastlingBlackRight = false
        }
        // ルークも動いたらキャスリングできなくなる。
        if( (numberOfPlaceY == 7 && numberOfPlaceX == 0 ) || (numberOfPlaceNextY == 7 && numberOfPlaceNextX == 0 ) ){
            abilityOfCastlingWhiteLeft = false
        }
        if( (numberOfPlaceY == 7 && numberOfPlaceX == 7 ) || (numberOfPlaceNextY == 7 && numberOfPlaceNextX == 7 ) ){
            abilityOfCastlingWhiteRight = false
        }
        if( (numberOfPlaceY == 0 && numberOfPlaceX == 0 ) || (numberOfPlaceNextY == 0 && numberOfPlaceNextX == 0 ) ){
            abilityOfCastlingBlackLeft = false
        }
        if( (numberOfPlaceY == 0 && numberOfPlaceX == 7 ) || (numberOfPlaceNextY == 0 && numberOfPlaceNextX == 7 ) ){
            abilityOfCastlingBlackRight = false
        }
        
        // ポーンのプロモーションの処理
        if( ( statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA == 121 && numberOfPlaceY == 1 ) || ( statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA == 141 && numberOfPlaceY == 6 ) ){
            //        promotionAlert()
            isWantedToSelectPromotionG = true
            ret = true
        }
        
        // 一般的な処理
        // アンパッサン
        if( statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA == numOfAllyPorn && numOfEnPassant == numberOfPlaceNextX ){
            statusArrayG[numberOfPlaceNextY + pm][numberOfPlaceNextX].nOPA = 0
        }
        
        // 行き先が穴の場合、元いた場所が空白になる。
        if(numberOfNextSteats == 30){
            statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA = 0
        }
            // キャスリングするとき
            // キングサイドキャスリング
        else if( statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA % 20 == 8 && numberOfPlaceNextX - numberOfPlaceX == 2 ){
            statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA = statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA
            statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA = 0
            switch side {
            case 1:
                statusArrayG[7][7].nOPA = 0
                statusArrayG[7][5].nOPA = 122
                break
                
            case 2:
                statusArrayG[0][7].nOPA = 0
                statusArrayG[0][5].nOPA = 142
                break
                
            default:
                break
            }
        }
            // クイーンサイドキャスリング
        else if( statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA % 20 == 8 && numberOfPlaceNextX - numberOfPlaceX == -2 ){
            statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA = statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA
            statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA = 0
            switch side {
            case 1:
                statusArrayG[7][0].nOPA = 0
                statusArrayG[7][3].nOPA = 122
                break
                
            case 2:
                statusArrayG[0][0].nOPA = 0
                statusArrayG[0][3].nOPA = 142
                break
                
            default:
                break
            }
        }
            
            // 元いた場所が空白になり、行き先が自分の番号になる
        else{
            statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA = statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA
            statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA = 0
        }
        
        // 移動した後は移動可能性を記録する配列とボタンの色をリセットしておく
        drawKoma()
        if( nOPA % 10 == 1 && numOfCheckY - numOfCheckNextY == 2 || numOfCheckY - numOfCheckNextY == -2 ){
            numOfEnPassant = numberOfPlaceNextX
        }
        else{
            numOfEnPassant = -1
        }
        print("moveChessfunc",ret)
        return ret
    }
    
    func isAbleToMoveChess(placeX: Int, placeY: Int,direct: Int) -> Bool{
        let nOAOM: Int = statusArrayG[placeY][placeX].defence
        var ret = true
        if( nOAOM == 0 || (nOAOM % 10) % 4 == direct % 4  ){
            ret = true
        }
        else{
            switch nOAOM % 2 {
            case 1:
                if( isAbleToMove(placeX: placeX, placeY: placeY, komaID: 2) == false || isAbleToMove(placeX: placeX, placeY: placeY, komaID: 5) == false ){
                    ret = false
                }
                break
                
            case 0:
                if( isAbleToMove(placeX: placeX, placeY: placeY, komaID: 3) == false || isAbleToMove(placeX: placeX, placeY: placeY, komaID: 5) == false ){
                    ret = false
                }
                break
                
            default:
                break
            }
        }
        return ret
    }
}
