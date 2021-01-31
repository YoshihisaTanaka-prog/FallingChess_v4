
//
//  MainFuncs.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/08/17.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import Foundation
import UIKit

func settingFirstOfAll(){
    var numOfPeriodMemo: Int!
    var numOfGameModeMemo: Int!
    var numOfTimeModeMemo: Int!
    var numOfDesignMemo: Int!
    var numOfButtonAlphaMemo: Float!
    var isSucideMemo: Bool!
    var isJumpMemo: Bool!
    var isNoticeMemo: Bool!
    var isOpenMemo: Bool!
    var isFirstTimeMemo: Bool!
    var isShowBanchiMemo: Bool!
    var userNameMemo: String!
    
    let ud = UserDefaults.standard
    
    ud.register(defaults: [
        "numOfPeriod" : 3,
        "numOfGameMode" : 0,
        "numOfTimeMode" : 1,
        "numOfDesign" : 4,
        "numOfButtonAlpha": 0.9,
        "isSucide" : false,
        "isJump" : false,
        "isNotice": false,
        "isOpen": false,
        "isNotSameAsSilver" : true,
        "isNotSameAsFu" : true,
        "isFirstTime" : true,
        "isShowBanchi" : true,
        "userName" : "user"
    ])
    
    numOfPeriodMemo = ud.integer(forKey: "numOfPeriod")
    numOfPeriod = numOfPeriodMemo!
    
    numOfGameModeMemo = ud.integer(forKey: "numOfGameMode")
    numOfGameMode = numOfGameModeMemo!
    
    numOfTimeModeMemo = ud.integer(forKey: "numOfTimeMode")
    numOfTimeMode = numOfTimeModeMemo!
    
    numOfDesignMemo = ud.integer(forKey: "numOfDesign")
    numOfDesign = numOfDesignMemo!
    
    numOfButtonAlphaMemo = ud.float(forKey: "numOfButtonAlpha")
    numOfButtonAlpha = numOfButtonAlphaMemo!
    
    isSucideMemo = ud.bool(forKey: "isSucide")
    isSucide = isSucideMemo!
    
    isJumpMemo = ud.bool(forKey: "isJump")
    isJump = isJumpMemo!
    
    isNoticeMemo = ud.bool(forKey: "isNotice")
    isNotice = isNoticeMemo!
    
    isOpenMemo = ud.bool(forKey: "isOpen")
    isOpen = isOpenMemo!
    
    isFirstTimeMemo = ud.bool(forKey: "isFirstTime")
    isFirstTime = isFirstTimeMemo!
    
    isShowBanchiMemo = ud.bool(forKey: "isShowBanchi")
    isShowBanchi = isShowBanchiMemo!
    
    userNameMemo = ud.object(forKey: "userName") as? String
    userName = userNameMemo!
    
    backOfBackGroundImageG = UIImage(named: "BG" + String(numOfGameMode * 100 + numOfDesign + 100) + ".PNG")
    backGroundImageG = UIImage(named: "bg" + String(numOfGameMode * 100 + numOfDesign + 110) + ".png")
}

extension UIViewController{

    func drawKoma(){
        for i in 0..<numOfSquare{
            for j in 0..<numOfSquare{
                if(isShowBanchi){
                    if( statusArrayG[i][j].nOPA == 0 ){
                        buttonArray[i][j].setTitle(banchiG[ i * numOfSquare + j ], for: .normal)
                        buttonArray[i][j].setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
                    }
                    else{
                        buttonArray[i][j].setTitle("", for: .normal)
                    }
                }
                buttonArray[i][j].backgroundColor = colorArray[i][j]
                buttonArray[i][j].setBackgroundImage(UIImage(named: String( statusArrayG[i][j].nOPA ) + ".png"), for: .normal)
                statusArrayG[i][j].iATM = false
            }
        }
    }
    
    func tapped(numberOfX: Int, numberOfY: Int){
        switch numOfMode {
        case 0:
            tappedEven(numberOfX: numberOfX, numberOfY: numberOfY, side: 1)
            break
            
        case 1:
            tappedOdd(numberOfX: numberOfX, numberOfY: numberOfY)
            break
            
        case 2:
            tappedEven(numberOfX: numberOfX, numberOfY: numberOfY, side: 2)
            break
            
        case 3:
            tappedOdd(numberOfX: numberOfX, numberOfY: numberOfY)
            break
            
        case 5:
            tappedMochiGoma(numberOfX: numberOfX, numberOfY: numberOfY, side: 1)
            break
            
        case 6:
            tappedMochiGoma(numberOfX: numberOfX, numberOfY: numberOfY, side: 2)
            break
            
        default:
            break
        }
        if( numOfMode == 4 ){
            numOfMode = 0
        }
    }
    
    
    func tappedEven(numberOfX: Int, numberOfY: Int, side: Int){
        clearAbitityArray()
        
        isUchiFu = false
        
        if( statusArrayG[numberOfY][numberOfX].nOPA % 100 > side * 20 && statusArrayG[numberOfY][numberOfX].nOPA % 100 < side * 20 + 19 ){
            numberOfPlaceX = numberOfX
            numberOfPlaceY = numberOfY
            isNegative = false
            if( searchIsAbleToMove( komaNum: statusArrayG[numberOfY][numberOfX].nOPA % 100, isValueOfAlly: false ) == 0 ){
                self.showAlertYT(titleYT: "注意", textYT: "その駒は移動できません", buttonsYT: ["OK"], numOfmodeYT: 0)
            }
            else{
                buttonArray[numberOfY][numberOfX].backgroundColor = UIColor(red:1,green:1,blue:0,alpha:1)
                numOfMode = numOfMode + 1
            }
            //        printArray([1])
        }
        else if(statusArrayG[numberOfY][numberOfX].nOPA % 100 > ( 3 - side ) * 20 && statusArrayG[numberOfY][numberOfX].nOPA % 100 < ( 3 - side ) * 20 + 19 && statusArrayG[numberOfY][numberOfX].nOPA != 30 && !isOnLine ){
            switch [numOfGameMode,side] {
            case [0,1]:
                self.showAlertYT(titleYT: "注意", textYT: "白の番です。", buttonsYT: ["OK"], numOfmodeYT: 0)
            case [0,2]:
                self.showAlertYT(titleYT: "注意", textYT: "黒の番です。", buttonsYT: ["OK"], numOfmodeYT: 0)
            case [1,1]:
                self.showAlertYT(titleYT: "注意", textYT: "先手の番です。", buttonsYT: ["OK"], numOfmodeYT: 0)
            case [1,2]:
                self.showAlertYT(titleYT: "注意", textYT: "後手の番です。", buttonsYT: ["OK"], numOfmodeYT: 0)
            default:
                break
            }
        }
    }
    
    func tappedOdd(numberOfX: Int, numberOfY: Int){
        if( statusArrayG[numberOfY][numberOfX].iATM ){
            if(isOnLine){
                isWantedToStartLoading = true
            }
            
            numberOfPlaceNextX = numberOfX
            numberOfPlaceNextY = numberOfY
            isNotSellectingPromotionG = !move(side: ( numOfTurn % 2 + 1 ))
            //        print(isNotSellectingPromotionG)
            numOfMode = numOfMode + 1
            numOfTurn = numOfTurn + 1
            
            makeHole()
            
            //        if( saveStatus.isThousand() ){
            //            thousandAlert()
            //        }
            //        
            drawKoma()
            // 動かしたので必要なくなったデータを消す。
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
        else if( numberOfX == numberOfPlaceX && numberOfY == numberOfPlaceY ){
            // 選択取り消しをした後は移動可能性を記録する配列とボタンの色をリセットしておく
            drawKoma()
            // モードも一つ戻しておく
            numOfMode = numOfMode - 1
        }
        else{
            self.showAlertYT(titleYT: "注意", textYT: "そこには移動できません", buttonsYT: ["OK"], numOfmodeYT: 0)
        }
    }
    
    func shuffle(){
        print(numOfShuffledArray)
        var numberOfKept: Int = 0
        var numberOfSeibun: Int = 0
        for i in 0..<numOfSquare*numOfSquare{
            numberOfSeibun = rand(minYT: i, maxYT: numOfSquare * numOfSquare - 1)
            numberOfKept = numOfShuffledArray[i]
            numOfShuffledArray[i] = numOfShuffledArray[numberOfSeibun]
            numOfShuffledArray[numberOfSeibun] = numberOfKept
        }
        //    print(numOfShuffledArray)
    }
    
    func makeHole(){
        
        if( numOfTurn % numOfPeriod == 0 ){
            let numOfplaceX: Int = numOfShuffledArray[ numOfTurn / numOfPeriod - 1 ] % numOfSquare
            let numOfplaceY: Int = numOfShuffledArray[ numOfTurn / numOfPeriod - 1 ] / numOfSquare
            
            statusArrayG[numOfplaceY][numOfplaceX].nOPA = 30
            colorArray[numOfplaceY][numOfplaceX] = UIColor(red:0,green:0,blue:0,alpha:1)
            colorOfEnableToMovePlace[0][numOfplaceY][numOfplaceX] = UIColor(red:1,green:0,blue:0,alpha:1)
            colorOfEnableToMovePlace[1][numOfplaceY][numOfplaceX] = UIColor(red:0,green:0,blue:1,alpha:1)
            drawKoma()
            
            if( statusArrayG[numOfplaceY][numOfplaceX].nOPA % 20 == 8 ){
                hougyoAlert(3 - ( statusArrayG[numOfplaceY][numOfplaceX].nOPA % 100 ) / 20)
            }
            else{
                holeAlert()
            }
            
            switch [numOfGameMode,numOfplaceY,numOfplaceX] {
            case [0,0,0]:
                abilityOfCastlingBlackLeft = false
                break
                
            case [0,0,7]:
                abilityOfCastlingBlackRight = false
                break
                
            case [0,7,0]:
                abilityOfCastlingWhiteLeft = false
                break
                
            case [0,7,7]:
                abilityOfCastlingWhiteRight = false
                break
                
            default:
                break
            }
        }
    }
    
    func searchIsAbleToMove( komaNum: Int , isValueOfAlly: Bool ) -> Int{
        let koma: Int = komaNum % 20
        var numberOfReturn:Int = 0
        
        if( numOfReturnOfhecked < 2 ){
            switch numOfGameMode{
            case 0:
                switch koma {
                case 1:
                    //                print("Porn",komaNum / 20)
                    moveOfPorn(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    break
                    
                case 2:
                    //                print("Rook",komaNum / 20)
                    moveOfRook(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    break
                    
                case 3:
                    //                print("Knight",komaNum / 20)
                    moveOfKnight(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    break
                    
                case 4:
                    //                print("Bishop",komaNum / 20)
                    moveOfBishop(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    break
                    
                case 5:
                    //                print("Queen",komaNum / 20)
                    moveOfRook(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    moveOfBishop(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    break
                    
                case 8:
                    //                print("King",komaNum / 20)
                    moveOfKing(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    break
                    
                default:
                    break
                }
                break
                
            case 1:
                switch koma {
                case 1:
                    //                print("歩兵",komaNum / 20)
                    moveOfFu(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    break
                    
                case 2:
                    //                print("香車",komaNum / 20)
                    moveOfKyou(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    break
                    
                case 3:
                    //                print("桂馬",komaNum / 20)
                    moveOfKeima(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    break
                    
                case 4:
                    //                print("銀",komaNum / 20)
                    moveOfFu(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    moveOfSilver(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    break
                    
                case 5:
                    //                print("金",komaNum / 20)
                    moveOfGold(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    break
                    
                case 6:
                    //                print("角行",komaNum / 20)
                    moveOfKaku(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    break
                    
                case 7:
                    //                print("飛車",komaNum / 20)
                    moveOfHisha(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    break
                    
                case 8:
                    //                print("王or玉",komaNum / 20)
                    moveOfGyoku(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    break
                    
                case 11:
                    //                print("と金",komaNum / 20)
                    moveOfGold(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    break
                    
                case 12:
                    //                print("成香",komaNum / 20)
                    moveOfGold(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    break
                    
                case 13:
                    //                print("成桂",komaNum / 20)
                    moveOfGold(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    break
                    
                case 14:
                    //                print("成銀",komaNum / 20)
                    moveOfGold(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    break
                    
                case 16:
                    //                print("龍馬",komaNum / 20)
                    moveOfKaku(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    moveOfGold(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    break
                    
                case 17:
                    //                print("龍王",komaNum / 20)
                    moveOfHisha(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    moveOfSilver(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    break
                    
                default:
                    break
                }
                break
                
            case 2:
                switch koma {
                case 1:
                    break
                    
                default:
                    break
                }
                break
                
            case 3:
                switch koma {
                case 1:
                    break
                    
                default:
                    break
                }
                break
                
            default:
                break
            }
            
            if( numOfReturnOfhecked == 1 && koma != 8 ){
                for i in 0..<numOfSquare {
                    for j in 0..<numOfSquare {
                        if( statusArrayG[i][j].offence == 0 ){
                            statusArrayG[i][j].iATM = false
                            buttonArray[i][j].backgroundColor = colorArray[i][j]
                        }
                    }
                }
            }
            
        }
        else{
            if( koma == 8 ){
                switch numOfGameMode {
                case 0:
                    print("King",komaNum / 20)
                    moveOfKing(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    break
                    
                case 1:
                    print("王or玉",komaNum / 20)
                    moveOfGyoku(side: komaNum / 20, isValueOfAlly: isValueOfAlly)
                    break
                    
                case 2:
                    break
                    
                case 3:
                    break
                    
                default:
                    break
                }
            }
        }
        // 移動可能な場所の数を数える。
        for i in 0..<numOfSquare{
            for j in 0..<numOfSquare{
                if( statusArrayG[i][j].iATM ){
                    numberOfReturn = numberOfReturn + 1
                }
            }
        }
        return numberOfReturn
    }
    
    func move(side: Int)->Bool{
        
        var ret:Bool = false
        switch numOfGameMode {
        case 0:
            ret = moveChess(side: side)
            break
            
        case 1:
            ret = moveShogi(side: side)
            break
            
        case 2:
            //        ret = moveMak(side: side)
            break
            
        case 3:
            //        ret = moveChat(side: side)
            break
            
        default:
            break
        }
        return ret
    }
    
    func clearAbitityArray(){
        var numOfWhiteKingX: Int = -1
        var numOfWhiteKingY: Int = -1
        var numOfBlackKingX: Int = -1
        var numOfBlackKingY: Int = -1
        for i in 0..<numOfSquare{
            for j in 0..<numOfSquare{
                statusArrayG[i][j].iATM = false
                statusArrayG[i][j].defence = 0
                if( statusArrayG[i][j].nOPA % 100 == 28 ){
                    numOfWhiteKingX = j
                    numOfWhiteKingY = i
                }
                if( statusArrayG[i][j].nOPA % 100 == 48 ){
                    numOfBlackKingX = j
                    numOfBlackKingY = i
                }
            }
        }
        if numOfWhiteKingX == -1 {
            hougyoAlert(2)
            return
        }
        if numOfBlackKingX == -1 {
            hougyoAlert(1)
            return
        }
        wall(placeX: numOfWhiteKingX, placeY: numOfWhiteKingY, side: 1)
        wall(placeX: numOfBlackKingX, placeY: numOfBlackKingY, side: 2)
        //    printArray([2])
    }
    
    func wall(placeX: Int , placeY: Int, side: Int){
        for i in 1..<9{
            wallLoop(placeX: placeX, placeY: placeY, side: side, direct: i)
        }
    }
    
    func wallLoop(placeX: Int, placeY: Int, side: Int, direct: Int){
        var numI = 1
        var checkPlaceX: Int = 0
        var checkPlaceY: Int = 0
        let enemyRangeMinmum: Int = numOfGameMode * 100 + (3 - side) * 20 + 100
        let enemyRangeMaximum: Int = numOfGameMode * 100 + (3 - side) * 20 + 119
        let allyRangeMinmum: Int = numOfGameMode * 100 + side * 20 + 100
        let allyRangeMaximum: Int = numOfGameMode * 100 + side * 20 + 119
        var pm: Int = 0
        var nOPA: Int = 0
        
        switch side {
        case 1:
            pm = 1
            break
            
        default:
            pm = -1
            break
            
        }
        
        while numI < numOfSquare {
            switch direct {
            case 1:
                checkPlaceX = placeX
                checkPlaceY = placeY - numI * pm
                break
                
            case 2:
                checkPlaceX = placeX + numI * pm
                checkPlaceY = placeY - numI * pm
                break
                
            case 3:
                checkPlaceX = placeX + numI * pm
                checkPlaceY = placeY
                break
                
            case 4:
                checkPlaceX = placeX + numI * pm
                checkPlaceY = placeY + numI * pm
                break
                
            case 5:
                checkPlaceX = placeX
                checkPlaceY = placeY + numI * pm
                break
                
            case 6:
                checkPlaceX = placeX - numI * pm
                checkPlaceY = placeY + numI * pm
                break
                
            case 7:
                checkPlaceX = placeX - numI * pm
                checkPlaceY = placeY
                break
                
            case 8:
                checkPlaceX = placeX - numI * pm
                checkPlaceY = placeY - numI * pm
                break
                
            default:
                break
            }
            if( checkPlaceX < 0 || checkPlaceX >= numOfSquare || checkPlaceY < 0 || checkPlaceY >= numOfSquare ){
                break
            }
            nOPA = statusArrayG[checkPlaceY][checkPlaceX].nOPA
            if( enemyRangeMinmum < nOPA && nOPA < enemyRangeMaximum ){
                break
            }
            if( allyRangeMinmum < nOPA && nOPA < allyRangeMaximum ){
                statusArrayG[checkPlaceY][checkPlaceX].defence = side * 10 + direct
                break
            }
            numI = numI + 1
        }
    }
    
    func isAbleToMove(placeX: Int, placeY: Int, komaID: Int) -> Bool{
        let side: Int = ( statusArrayG[placeY][placeX].nOPA % 100 ) / 20
        let direct: Int = ( statusArrayG[placeY][placeX].defence ) % 10
        var ret: Bool = true
        let allyRangeMinmum: Int = numOfGameMode * 100 + side * 20 + 100
        let allyRangeMaximum: Int = numOfGameMode * 100 + side * 20 + 119
        var pm: Int = 0
        var nOPA: Int = 0
        var checkPlaceX: Int = 0
        var checkPlaceY: Int = 0
        var numI: Int = 1
        
        switch side {
        case 1:
            pm = 1
            break
            
        default:
            pm = -1
        }
        while numI < numOfSquare{
            switch direct {
            case 1:
                checkPlaceX = placeX
                checkPlaceY = placeY - numI * pm
                break
                
            case 2:
                checkPlaceX = placeX + numI * pm
                checkPlaceY = placeY - numI * pm
                break
                
            case 3:
                checkPlaceX = placeX + numI * pm
                checkPlaceY = placeY
                break
                
            case 4:
                checkPlaceX = placeX + numI * pm
                checkPlaceY = placeY + numI * pm
                break
                
            case 5:
                checkPlaceX = placeX
                checkPlaceY = placeY + numI * pm
                break
                
            case 6:
                checkPlaceX = placeX - numI * pm
                checkPlaceY = placeY + numI * pm
                break
                
            case 7:
                checkPlaceX = placeX - numI * pm
                checkPlaceY = placeY
                break
                
            case 8:
                checkPlaceX = placeX - numI * pm
                checkPlaceY = placeY - numI * pm
                break
                
            default:
                break
            }
            if( checkPlaceX < 0 || checkPlaceX >= numOfSquare || checkPlaceY < 0 || checkPlaceY >= numOfSquare ){
                break
            }
            nOPA = statusArrayG[checkPlaceY][checkPlaceX].nOPA
            if( nOPA == (numOfGameMode + 1) * 100 + (3 - side) * 20 + komaID ){
                ret = false
                break
            }
            if( ( allyRangeMinmum < nOPA && nOPA < allyRangeMaximum ) || ( nOPA == 30 && isJump == false ) ){
                break
            }
            numI = numI + 1
        }
        return ret
    }
    
    func isChecked(side: Int) -> Int{
        var ret: Int = 0
        let enemyRangiMinimun: Int = (numOfGameMode + 1) * 100 + (3 - side) * 20
        let enemyRangiMaximun: Int = (numOfGameMode + 1) * 100 + (3 - side) * 20 + 19
        let numOfKeptX: Int = numberOfPlaceX
        let numOfKeptY: Int = numberOfPlaceY
        var numOfKingX: Int = 0
        var numOfKingY: Int = 0
        var nOPA: Int = 0
        
        for i in 0..<numOfSquare {
            for j in 0..<numOfSquare {
                nOPA = statusArrayG[i][j].nOPA
                if( nOPA == (numOfGameMode + 1)*100 + 20 * side + 8 ){
                    numOfKingX = j
                    numOfKingY = i
                }
            }
        }
        
        for i in 0..<numOfSquare {
            for j in 0..<numOfSquare {
                nOPA = statusArrayG[i][j].nOPA
                numberOfPlaceY = i
                numberOfPlaceX = j
                if(enemyRangiMinimun < nOPA && nOPA < enemyRangiMaximun){
                    nOPA = searchIsAbleToMove(komaNum: nOPA % 100, isValueOfAlly: true)
                    for ii in 0..<numOfSquare {
                        for jj in 0..<numOfSquare {
                            if(statusArrayG[ii][jj].iATM){
                                statusArrayG[ii][jj].iEATA = true
                            }
                        }
                    }
                }
                
                if(statusArrayG[numOfKingY][numOfKingX].iATM){
                    statusArrayG[i][j].offence = side * 10 + getDirection(side: side, kx: numOfKingX, ky: numOfKingY, i: i, j: j)
                }
                drawKoma()
            }
        }
        
        //    printArray([4])
        
        print("isChecked >>", [side,numOfTurn])
        //    printArray([3])
        
        numberOfPlaceX = numOfKeptX
        numberOfPlaceY = numOfKeptY
        
        for i in 0..<numOfSquare {
            for j in 0..<numOfSquare {
                nOPA = statusArrayG[i][j].offence
                if(nOPA > side * 10){
                    ret = ret + 1
                }
            }
        }
        
        return ret
    }
    
    func getDirection(side:Int, kx:Int, ky:Int, i:Int, j:Int) -> Int{
        if( statusArrayG[i][j].nOPA % 20 == 3 ){
            return 9
        }
        
        var x: Int = 0
        var y: Int = 0
        var pm: Int = 0
        var numI: Int = 1
        
        switch side {
        case 1:
            pm = 0
            break
            
        default:
            pm = 4
            break
        }
        
        
        if( kx < j ){
            x = 1
        }
        if( kx > j ){
            x = -1
        }
        if( ky < i ){
            y = 1
        }
        if( ky > i ){
            y = -1
        }
        
        switch [x,y] {
        case [0,-1]:
            while( ky - numI != i ){
                statusArrayG[ky - numI][kx].offence = 1
                numI = numI + 1
            }
            return 1 + pm
            
        case [1,-1]:
            while( ky - numI != i ){
                statusArrayG[ky - numI][kx + numI].offence = 1
                numI = numI + 1
            }
            return 2 + pm
            
        case [1,0]:
            while( kx + numI != j ){
                statusArrayG[ky][kx + numI].offence = 1
                numI = numI + 1
            }
            return 3 + pm
            
        case [1,1]:
            while( kx + numI != j ){
                statusArrayG[ky + numI][kx + numI].offence = 1
                numI = numI + 1
            }
            return 4 + pm
            
        case [0,1]:
            while( ky + numI != i ){
                statusArrayG[ky + numI][kx].offence = 1
                numI = numI + 1
            }
            return 5 - pm
            
        case [-1,1]:
            while( ky + numI != i ){
                statusArrayG[ky + numI][kx - numI].offence = 1
                numI = numI + 1
            }
            return 6 - pm
            
        case [-1,0]:
            while( kx - numI != j ){
                statusArrayG[ky][kx - numI].offence = 1
                numI = numI + 1
            }
            return 7 - pm
            
        case [-1,-1]:
            while( kx - numI != j ){
                statusArrayG[ky - numI][kx - numI].offence = 1
                numI = numI + 1
            }
            return 8 - pm
            
        default:
            break
        }
        
        return 0
    }
    
    
    func countNumOfChoice(side: Int)->Int{
        var ret: Int = 0
        var nOPA: Int = 0
        let numOfKeptX: Int = numberOfPlaceX
        let numOfKeptY: Int = numberOfPlaceY
        let allyRangiMinimun: Int = (numOfGameMode + 1) * 100 + side * 20
        let allyRangiMaximun: Int = (numOfGameMode + 1) * 100 + side * 20 + 19
        
        for i in 0..<numOfSquare {
            for j in 0..<numOfSquare {
                numberOfPlaceY = i
                numberOfPlaceX = j
                nOPA = statusArrayG[i][j].nOPA
                if( allyRangiMinimun < nOPA && nOPA < allyRangiMaximun ){
                    ret = ret + searchIsAbleToMove(komaNum: nOPA % 100 , isValueOfAlly: false)
                    //                print("countNumOfChoice >>",[j,i])
                    //                printArray([1])
                    drawKoma()
                }
            }
        }
        
        if( numOfGameMode == 1 ){
            for i in 1..<8 {
                ret = ret + mochiGomaPut(side: side, koma: i)
                drawKoma()
            }
        }
        
        numberOfPlaceX = numOfKeptX
        numberOfPlaceY = numOfKeptY
        
        return ret
    }
    
    func checkcheck(){
        if(numOfMode % 2 == 0 && numOfLastHoleAlertedG != numOfTurn){
            print(numOfMode,2 - numOfMode / 2)
            numOfReturnOfhecked = isChecked(side: numOfMode / 2 + 1)
            numOfLastHoleAlertedG = numOfTurn
            if( ( numOfReturnOfhecked > 0 ) ){
                if( countNumOfChoice(side: 1 + numOfMode / 2) == 0 ){
                    if( numOfGameMode == 1 && isUchiFu ){
                        utihudumeAlert()
                    }
                    else{
                        checkmateAlert(2 - numOfMode / 2)
                    }
                }
                else{
                    checkedAlert()
                }
            }
            else if( countNumOfChoice(side: 1 + numOfMode / 2) == 0 ){
                if( numOfGameMode == 1 ){
                    if( isUchiFu ){
                        utihudumeAlert()
                    }
                    else{
                        checkmateAlert(2 - numOfMode / 2)
                    }
                }
                else{
                    stalemateAlert()
                }
            }
        }
    }
}
