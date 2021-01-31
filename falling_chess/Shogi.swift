//
//  Shogi.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/08/20.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func moveShogi(side: Int)->Bool{
        var ret:Bool = false
        let numberOfNextSteats: Int = statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA
        
        // 成り駒
        if( statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA % 20 != 5 &&
            statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA % 20 != 8 &&
            statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA % 20 < 10 &&
            (( side == 1 && (numberOfPlaceNextY < 3 || numberOfPlaceY < 3 ) ) ||
                (side == 2 && ( numberOfPlaceNextY > 5 || numberOfPlaceY > 5 ))) ){
            // 歩と香車が動けない場合の処理
            if( statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA % 20 < 3 && (side == 1 && numberOfPlaceNextY == 0 || side == 2 && numberOfPlaceNextY == 8 ) ){
                statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA = statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA + 10
            }
                // 桂馬が動けない場合の処理
            else if( statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA % 20 == 3 && (side == 1 && numberOfPlaceNextY < 2 || side == 2 && numberOfPlaceNextY > 6 ) ){
                statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA = statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA + 10
            }
            else{
                //            promotionAlert()
                isWantedToSelectPromotionG = true
                ret = true
            }
        }
        
        // 一般的な処理
        // 行き先が穴の場合、元いた場所が空白になる。
        if(numberOfNextSteats == 30){
            statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA = 0
        }
            // 元いた場所が空白になり、行き先が自分の番号になる
        else{
            if(numberOfNextSteats != 0){
                mochiGomaGet(side: side, koma: numberOfNextSteats % 10)
            }
            statusArrayG[numberOfPlaceNextY][numberOfPlaceNextX].nOPA = statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA
            statusArrayG[numberOfPlaceY][numberOfPlaceX].nOPA = 0
        }
        
        // 移動した後は移動可能性を記録する配列とボタンの色をリセットしておく
        drawKoma()
        return ret
    }
    
    func checkShogi(side: Int, placeX: Int, placeY: Int, isValueOfAlly: Bool) -> Bool{
        let numberOfEnemyRangeMin: Int = ( 3 - side ) * 20 + 200
        let numberOfEnemyRangeMax: Int = ( 3 - side ) * 20 + 219
        let numberOfAllyRangeMin: Int = side * 20 + 200
        let numberOfAllyRangeMax: Int = side * 20 + 219
        
        // 行き先がボードの外になるとき
        if( placeX < 0 || placeX >= numOfSquare || placeY < 0 || placeY >= numOfSquare ){
            return false
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
            if( isSucide && statusArrayG[placeY][placeX].nOPA % 20 != 8 ){
                // (placeX,placeY)が移動可能であるとみなす。
                if isNegative {
                    statusArrayG[placeY][placeX].iATM = false
                    buttonArray[placeY][placeX].backgroundColor =  colorArray[placeY][placeX]
                }
                else{
                    statusArrayG[placeY][placeX].iATM = true
                    buttonArray[placeY][placeX].backgroundColor = colorOfEnableToMovePlace[side - 1][placeY][placeX]
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
            // 空白のとき
        else{
            if(isNegative){
                statusArrayG[placeY][placeX].iATM = false
                buttonArray[placeY][placeX].backgroundColor =  colorArray[placeY][placeX]
            }
            else{
                // (placeX,placeY)が移動可能であるとみなす。
                statusArrayG[placeY][placeX].iATM = true
                buttonArray[placeY][placeX].backgroundColor = colorOfEnableToMovePlace[side - 1][placeY][placeX]
            }
            return true
        }
    }
    
    
    func checkShogiVoid(side: Int, placeX: Int, placeY: Int, isValueOfAlly: Bool){
        let numberOfEnemyRangeMin: Int = ( 3 - side ) * 20 + 200
        let numberOfEnemyRangeMax: Int = ( 3 - side ) * 20 + 219
        let numberOfAllyRangeMin: Int = side * 20 + 200
        let numberOfAllyRangeMax: Int = side * 20 + 219
        
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
        else if( statusArrayG[placeY][placeX].nOPA == 30 ){
            // 自ら穴に落ちることができる時の処理
            if( isSucide && statusArrayG[placeY][placeX].nOPA % 20 != 8 ){
                // (placeX,placeY)が移動可能であるとみなす。
                if isNegative {
                    statusArrayG[placeY][placeX].iATM = false
                    buttonArray[placeY][placeX].backgroundColor =  colorArray[placeY][placeX]
                }
                else{
                    statusArrayG[placeY][placeX].iATM = true
                    buttonArray[placeY][placeX].backgroundColor = colorOfEnableToMovePlace[side - 1][placeY][placeX]
                }
            }
        }
            // 敵がいるとき
        else if( statusArrayG[placeY][placeX].nOPA > numberOfEnemyRangeMin && statusArrayG[placeY][placeX].nOPA < numberOfEnemyRangeMax ){
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
            // 空白のとき
        else{
            if(isNegative){
                statusArrayG[placeY][placeX].iATM = false
                buttonArray[placeY][placeX].backgroundColor =  colorArray[placeY][placeX]
            }
            else{
                // (placeX,placeY)が移動可能であるとみなす。
                statusArrayG[placeY][placeX].iATM = true
                buttonArray[placeY][placeX].backgroundColor = colorOfEnableToMovePlace[side - 1][placeY][placeX]
            }
        }
    }
    
    
    
    
    func moveOfGyoku(side: Int, isValueOfAlly: Bool){
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
        checkShogiVoid(side: side, placeX: numberOfPlaceX, placeY: numberOfPlaceY - pm, isValueOfAlly: isValueOfAlly)
        checkShogiVoid(side: side, placeX: numberOfPlaceX + pm, placeY: numberOfPlaceY - pm, isValueOfAlly: isValueOfAlly)
        checkShogiVoid(side: side, placeX: numberOfPlaceX + pm, placeY: numberOfPlaceY, isValueOfAlly: isValueOfAlly)
        checkShogiVoid(side: side, placeX: numberOfPlaceX + pm, placeY: numberOfPlaceY + pm, isValueOfAlly: isValueOfAlly)
        checkShogiVoid(side: side, placeX: numberOfPlaceX, placeY: numberOfPlaceY + pm, isValueOfAlly: isValueOfAlly)
        checkShogiVoid(side: side, placeX: numberOfPlaceX - pm, placeY: numberOfPlaceY + pm, isValueOfAlly: isValueOfAlly)
        checkShogiVoid(side: side, placeX: numberOfPlaceX - pm, placeY: numberOfPlaceY, isValueOfAlly: isValueOfAlly)
        checkShogiVoid(side: side, placeX: numberOfPlaceX - pm, placeY: numberOfPlaceY - pm, isValueOfAlly: isValueOfAlly)
        //    printArray([1,4])
        for i in 0..<numOfSquare {
            for j in 0..<numOfSquare {
                if( statusArrayG[i][j].iEATA ){
                    statusArrayG[i][j].iATM = false
                    buttonArray[i][j].backgroundColor = colorArray[i][j]
                }
            }
        }
        //    printArray([1])
    }
    
    func moveOfHisha(side: Int, isValueOfAlly: Bool){
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
        if( isAbleToMoveShogi(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 3) ){
            while(checkShogi(side: side, placeX: numberOfPlaceX + numI, placeY: numberOfPlaceY, isValueOfAlly: isValueOfAlly)){
                numI = numI + pm
            }
            numI = pm
            while(checkShogi(side: side, placeX: numberOfPlaceX - numI, placeY: numberOfPlaceY, isValueOfAlly: isValueOfAlly)){
                numI = numI + pm
            }
        }
        
        if( isAbleToMoveShogi(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 1) ){
            numI = pm
            while(checkShogi(side: side, placeX: numberOfPlaceX, placeY: numberOfPlaceY + numI, isValueOfAlly: isValueOfAlly)){
                numI = numI + pm
            }
            numI = pm
            while(checkShogi(side: side, placeX: numberOfPlaceX, placeY: numberOfPlaceY - numI, isValueOfAlly: isValueOfAlly)){
                numI = numI + pm
            }
        }
    }
    
    func moveOfKaku(side: Int, isValueOfAlly: Bool){
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
        if( isAbleToMoveShogi(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 4) ){
            while(checkShogi(side: side, placeX: numberOfPlaceX + numI, placeY: numberOfPlaceY + numI, isValueOfAlly: isValueOfAlly)){
                numI = numI + pm
            }
            numI = pm
            while(checkShogi(side: side, placeX: numberOfPlaceX - numI, placeY: numberOfPlaceY - numI, isValueOfAlly: isValueOfAlly)){
                numI = numI + pm
            }
        }
        
        if( isAbleToMoveShogi(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 2) ){
            numI = pm
            while(checkShogi(side: side, placeX: numberOfPlaceX - numI, placeY: numberOfPlaceY + numI, isValueOfAlly: isValueOfAlly)){
                numI = numI + pm
            }
            numI = pm
            while(checkShogi(side: side, placeX: numberOfPlaceX + numI, placeY: numberOfPlaceY - numI, isValueOfAlly: isValueOfAlly)){
                numI = numI + pm
            }
        }
    }
    
    func moveOfGold(side: Int, isValueOfAlly: Bool){
        var pm : Int = 0
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
        if(isAbleToMoveShogi(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 3)){
            checkShogiVoid(side: side, placeX: numberOfPlaceX + pm, placeY: numberOfPlaceY, isValueOfAlly: isValueOfAlly)
            checkShogiVoid(side: side, placeX: numberOfPlaceX - pm, placeY: numberOfPlaceY, isValueOfAlly: isValueOfAlly)
        }
        if(isAbleToMoveShogi(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 1)){
            checkShogiVoid(side: side, placeX: numberOfPlaceX, placeY: numberOfPlaceY + pm, isValueOfAlly: isValueOfAlly)
            checkShogiVoid(side: side, placeX: numberOfPlaceX, placeY: numberOfPlaceY - pm, isValueOfAlly: isValueOfAlly)
        }
        if(isAbleToMoveShogi(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 2)){
            checkShogiVoid(side: side, placeX: numberOfPlaceX + pm, placeY: numberOfPlaceY - pm, isValueOfAlly: isValueOfAlly)
        }
        if(isAbleToMoveShogi(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 4)){
            checkShogiVoid(side: side, placeX: numberOfPlaceX - pm, placeY: numberOfPlaceY - pm, isValueOfAlly: isValueOfAlly)
        }
    }
    
    func moveOfSilver(side: Int, isValueOfAlly: Bool){
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
        
        if( isAbleToMoveShogi(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 4) ){
            checkShogiVoid(side: side, placeX: numberOfPlaceX + pm, placeY: numberOfPlaceY + pm, isValueOfAlly: isValueOfAlly)
            checkShogiVoid(side: side, placeX: numberOfPlaceX - pm, placeY: numberOfPlaceY - pm, isValueOfAlly: isValueOfAlly)
        }
        if( isAbleToMoveShogi(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 2) ){
            checkShogiVoid(side: side, placeX: numberOfPlaceX - pm, placeY: numberOfPlaceY + pm, isValueOfAlly: isValueOfAlly)
            checkShogiVoid(side: side, placeX: numberOfPlaceX + pm, placeY: numberOfPlaceY - pm, isValueOfAlly: isValueOfAlly)
        }
    }
    
    func moveOfKeima(side: Int, isValueOfAlly: Bool){
        var pm : Int = 0
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
        if( isAbleToMoveShogi(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 1) &&
            isAbleToMoveShogi(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 2) &&
            isAbleToMoveShogi(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 3) &&
            isAbleToMoveShogi(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 4)){
            checkShogiVoid(side: side, placeX: numberOfPlaceX + pm, placeY: numberOfPlaceY - 2 * pm, isValueOfAlly: isValueOfAlly)
            checkShogiVoid(side: side, placeX: numberOfPlaceX - pm, placeY: numberOfPlaceY - 2 * pm, isValueOfAlly: isValueOfAlly)
        }
    }
    
    func moveOfKyou(side: Int, isValueOfAlly: Bool){
        var pm : Int = 0
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
        var numI: Int = 1
        if( isAbleToMoveShogi(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 1) ){
            while(checkShogi(side: side, placeX: numberOfPlaceX, placeY: numberOfPlaceY - numI * pm, isValueOfAlly: isValueOfAlly)){
                numI = numI + 1
            }
        }
    }
    
    func moveOfFu(side: Int, isValueOfAlly: Bool){
        var pm : Int = 0
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
        if( isAbleToMoveShogi(placeX: numberOfPlaceX, placeY: numberOfPlaceY, direct: 1) ){
            checkShogiVoid(side: side, placeX: numberOfPlaceX, placeY: numberOfPlaceY - pm, isValueOfAlly: isValueOfAlly)
        }
    }
    
    func mochiGomaGet(side: Int,koma: Int){
        if( koma != 8 ){
            switch side {
            case 1:
                numOfMochiGomaWhite[koma - 1] = numOfMochiGomaWhite[koma - 1] + 1
                mochiWhiteLabelAtrray[koma - 1].text = String(numOfMochiGomaWhite[koma - 1])
                break
                
            case 2:
                numOfMochiGomaBlack[koma - 1] = numOfMochiGomaBlack[koma - 1] + 1
                mochiBlackLabelAtrray[koma - 1].text = String(numOfMochiGomaBlack[koma - 1])
                break
                
            default:
                break
            }
        }
    }
    
    func mochiGomaPut(side: Int,koma: Int) -> Int {
        var isFuOk: [Bool] = [true,true,true,true,true,true,true,true,true]
        var ret: Int = 0
        
        isUchiFu = false
        
        if(koma > 3){
            for i in 0..<numOfSquare{
                for j in 0..<numOfSquare{
                    if( statusArrayG[i][j].nOPA == 0 ){
                        statusArrayG[i][j].iATM = true
                        buttonArray[i][j].backgroundColor = colorOfEnableToMovePlace[side - 1][i][j]
                    }
                }
            }
        }
        switch koma {
        case 1:
            for i in 0..<numOfSquare{
                for j in 0..<numOfSquare{
                    if( statusArrayG[j][i].nOPA == 201 + side * 20 ){
                        isFuOk[i] = false
                    }
                }
            }
            for i in 0..<numOfSquare{
                if( i == 0 && side == 1 ){
                    continue
                }
                if( i == numOfSquare - 1 && side == 2 ){
                    continue
                }
                for j in 0..<numOfSquare{
                    if( statusArrayG[i][j].nOPA == 0 && isFuOk[j] ){
                        statusArrayG[i][j].iATM = true
                        buttonArray[i][j].backgroundColor = colorOfEnableToMovePlace[side - 1][i][j]
                    }
                }
            }
            for i in 0..<numOfSquare{
                isFuOk[i] = true
            }
            isUchiFu = true
            break
            
        case 2:
            for i in 0..<numOfSquare{
                if( i == 0 && side == 1 ){
                    continue
                }
                if( i == numOfSquare - 1 && side == 2 ){
                    continue
                }
                for j in 0..<numOfSquare{
                    if( statusArrayG[i][j].nOPA == 0 ){
                        statusArrayG[i][j].iATM = true
                        buttonArray[i][j].backgroundColor = colorOfEnableToMovePlace[side - 1][i][j]
                    }
                }
            }
            break
            
        case 3:
            for i in 0..<numOfSquare{
                if( ( i == 0 || i == 1 ) && side == 1 ){
                    continue
                }
                if( ( i == numOfSquare - 1 || i == numOfSquare - 2 ) && side == 2 ){
                    continue
                }
                for j in 0..<numOfSquare{
                    if( statusArrayG[i][j].nOPA == 0 ){
                        statusArrayG[i][j].iATM = true
                        buttonArray[i][j].backgroundColor = colorOfEnableToMovePlace[side - 1][i][j]
                    }
                }
            }
            break
            
        default:
            break
        }
        if( numOfReturnOfhecked == 1 ){
            for i in 0..<numOfSquare {
                for j in 0..<numOfSquare {
                    if( statusArrayG[i][j].offence == 0 ){
                        statusArrayG[i][j].iATM = false
                        buttonArray[i][j].backgroundColor = colorArray[i][j]
                    }
                }
            }
        }
        
        for i in 0..<numOfSquare {
            for j in 0..<numOfSquare {
                if( statusArrayG[i][j].iATM ){
                    ret = ret + 1
                }
            }
        }
        return ret
    }
    
    func tappedMochiGoma(numberOfX: Int, numberOfY: Int, side: Int){
        if( statusArrayG[numberOfY][numberOfX].iATM ){
            if(isOnLine){
                isWantedToStartLoading = true
            }
            statusArrayG[numberOfY][numberOfX].nOPA = numOfMochiGomaId
            
            numOfMode = side * 2
            
            numOfTurn = numOfTurn + 1
            self.makeHole()
            drawKoma()
            
            //        if( saveStatus.isThousand() ){
            //            thousandAlert()
            //        }
            for i in 0..<numOfSquare {
                for j in 0..<numOfSquare {
                    if(statusArrayG[i][j].nOPA == 30){
                        statusArrayG[i][j].iEATA = true
                    }
                    else{
                        statusArrayG[i][j].iEATA = false
                    }
                    statusArrayG[i][j].offence = 0
                }
            }
        }
        else{
            self.showAlertYT(titleYT: "注意", textYT: "そこには置けません。", buttonsYT: ["OK"], numOfmodeYT: 0)
        }
    }
    
    
    func isAbleToMoveShogi(placeX: Int, placeY: Int,direct: Int) -> Bool{
        let nOAOM: Int = statusArrayG[placeY][placeX].defence
        var ret = true
        if( nOAOM == 0 || (nOAOM % 10) % 4 == direct % 4 ){
            ret = true
        }
        else if( nOAOM % 10 == 1){
            ret = isAbleToMove(placeX: placeX, placeY: placeY, komaID: 7) && isAbleToMove(placeX: placeX, placeY: placeY, komaID: 17) && isAbleToMove(placeX: placeX, placeY: placeY, komaID: 2)
        }
        else{
            switch nOAOM % 2 {
            case 1:
                ret = isAbleToMove(placeX: placeX, placeY: placeY, komaID: 17) && isAbleToMove(placeX: placeX, placeY: placeY, komaID: 7)
                break
                
            case 0:
                ret = isAbleToMove(placeX: placeX, placeY: placeY, komaID: 16) && isAbleToMove(placeX: placeX, placeY: placeY, komaID: 6)
                break
                
            default:
                break
            }
        }
        return ret
    }
}
