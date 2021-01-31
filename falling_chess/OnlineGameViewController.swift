//
//  OnlineGameViewController.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/09/02.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import UIKit
import NCMB

class OnlineGameViewController: UIViewController {
    
    @IBOutlet weak var whiteTimeLabel: UILabel!
    @IBOutlet weak var blackTimeLabel: UILabel!
    @IBOutlet weak var touryouWhite: UIButton!
    
    var loadTimer: Timer!
    var sendTimer: Timer!
    var remainTimer: Timer!
    
    var numOfLastHoleAlerted: Int = 0
    var numOfLastTimeReseted: Int = 0
    
    var numOfLoad: Int = 0
    
    var isLoading: Bool = false
    var isMyTurn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isOnLine = true
        isWaiting = false
        
        first()
        
        blackTimeLabel.transform = blackTimeLabel.transform.rotated(by: Double.pi.f)
        whiteTimeLabel.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        blackTimeLabel.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.view.makeBackGround(isExistsNaviBar: false, isExistsTabBar: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        whiteTimeLabel.text = String(format: "%02d", numberOfWhiteRemainingTimeMinuteG) + ":" + String(format: "%02d", numberOfWhiteRemainingTimeSecondG)
        blackTimeLabel.text = String(format: "%02d", numberOfBlackRemainingTimeMinuteG) + ":" + String(format: "%02d", numberOfBlackRemainingTimeSecondG)
        
        drawKoma()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        isLoading = false
        isMyTurn = false
        
        if( numOfTurn != 0 ){
            makeHole()
            checkcheck()
            printArray([4])
        }
        
        if( (numOfTurn) % 2 == numOfMySide % 2 ){
            loadTimerStart()
            self.view.showThinking(isRotate: false, mySide: numOfMySide)
            self.view.bringSubviewToFront(touryouWhite)
        }
        else{
            remainTimerStart()
        }
        
        if(isPlaying == false){
            switch numOfMySide {
            case 1:
                showAlertYT(titleYT: "試合開始", textYT: "あなたは先手です。", buttonsYT: ["OK"], numOfmodeYT: 0)
            default:
                showAlertYT(titleYT: "試合開始", textYT: "あなたは後手です。", buttonsYT: ["OK"], numOfmodeYT: 0)
            }
            for alertController in alertControllersYT {
                print(alertController)
            }
            isPlaying = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.view.deleteDark()
        
        allTimerStop()
        
        if( isPlaying == false ){
            
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
            
            for buttons in buttonArray{
                for button in buttons{
                    button.removeFromSuperview()
                }
            }
            
            for button in mochiBlackButtonAtrray{
                button.removeFromSuperview()
            }
            for button in mochiWhiteButtonAtrray{
                button.removeFromSuperview()
            }
            
            statusArrayG.removeAll()
            numOfShuffledArray.removeAll()
            buttonArray.removeAll()
            colorArray.removeAll()
            colorOfEnableToMovePlace[0].removeAll()
            colorOfEnableToMovePlace[1].removeAll()
            banchiG.removeAll()
            mochiBlackButtonAtrray.removeAll()
            mochiWhiteButtonAtrray.removeAll()
            mochiWhiteLabelAtrray.removeAll()
            mochiBlackLabelAtrray.removeAll()
            numOfMochiGomaBlack = [0,0,0,0,0,0,0]
            numOfMochiGomaWhite = [0,0,0,0,0,0,0]
        }
    }
    
    func allTimerStop(){

        if( loadTimer != nil ){
            self.loadTimer.invalidate()
        }
        
        if( remainTimer != nil ){
            self.remainTimer.invalidate()
        }
        
        if( sendTimer != nil ){
            sendTimer.invalidate()
        }
    }
    
    func first(){
        
        numOfMode = 0
        numOfTurn = 0
        numOfReturnOfhecked = 0
        numOfChoice = 1
        isUchiFu = false
        numOfEnPassant = -1
        numOfLastHoleAlertedG = 0
        
        // マスの数を設定
        
        if(numOfGameMode == 1){
            numOfSquare = 9
        }
        else{
            numOfSquare = 8
        }
        
        // 駒の配置を設定
        
        if(isNotice){
            numOfWhenAlertG = numOfPeriod - 2
        }
        
        for i in 0..<numOfSquare{
            statusArrayG.append([])
            for j in 0..<numOfSquare{
                switch numOfGameMode {
                case 0:
                    statusArrayG[i].append(Status(nOPA: defaultChessArrayG[i][j],iATM: false, defence: 0, offence: 0, iEATA: false))
                    banchiG.append(chessBanchiG[i * numOfSquare + j])
                    break
                    
                case 1:
                    statusArrayG[i].append(Status(nOPA: defaultShogiArrayG[i][j],iATM: false, defence: 0, offence: 0, iEATA: false))
                    banchiG.append(shogiBanchiG[i * numOfSquare + j])
                    break
                    
                case 2:
                    statusArrayG[i].append(Status(nOPA: defaultChessArrayG[i][j],iATM: false, defence: 0, offence: 0, iEATA: false))
                    break
                    
                case 3:
                    statusArrayG[i].append(Status(nOPA: defaultChessArrayG[i][j],iATM: false, defence: 0, offence: 0, iEATA: false))
                    break
                    
                default:
                    break
                }
            }
        }
        
        // マスと駒を描画

        numOfTopMarginG = Int(UITabBarController().tabBar.frame.size.height + self.view.safeAreaInsets.top)
        numOfBottomMarginG = Int(self.view.safeAreaInsets.bottom)
        
        if( numOfGameMode == 1 ){
            let n1: Int = Int( UIScreen.main.bounds.size.width ) / numOfSquare
            let n2: Int = ( Int( UIScreen.main.bounds.size.height ) - 160 - numOfTopMarginG - numOfBottomMarginG ) / 11
            numOfWidthOfSquareG = min( n1 , n2 )
        }
        else{
            let n1: Int = Int( UIScreen.main.bounds.size.width ) / numOfSquare
            let n2: Int = ( Int( UIScreen.main.bounds.size.height ) - 160 - numOfTopMarginG - numOfBottomMarginG ) / numOfSquare
            numOfWidthOfSquareG = min( n1 , n2 )
        }
        numOfWidthOfmarginG = (Int(UIScreen.main.bounds.size.width) - numOfWidthOfSquareG * numOfSquare ) / 2
        numOfheightOfmarginG = (Int(UIScreen.main.bounds.size.height) - numOfWidthOfSquareG * numOfSquare ) / 2
        
        for i in 0..<numOfSquare{
            buttonArray.append([])
            colorArray.append([])
            colorOfEnableToMovePlace[0].append([])
            colorOfEnableToMovePlace[1].append([])
            for j in 0..<numOfSquare {
                addButtonsAndImages(i: i, j: j)
                // 背景色の設定
                if( numOfGameMode == 0 || numOfGameMode == 3 ){
                    if( (i+j) % 2 == 0 ){
                        colorArray[i].append( UIColor(red:227/255,green:225/255,blue:186/255,alpha:1))
                        colorOfEnableToMovePlace[0][i].append( UIColor(red:241/255,green:113/255,blue:93/255,alpha:1))
                        colorOfEnableToMovePlace[1][i].append( UIColor(red:113/255,green:113/255,blue:220/255,alpha:1))
                    }
                    else{
                        colorArray[i].append( UIColor(red:61/255,green:150/255,blue:56/255,alpha:1))
                        colorOfEnableToMovePlace[0][i].append( UIColor(red:157/255,green:76/255,blue:29/255,alpha:1))
                        colorOfEnableToMovePlace[1][i].append( UIColor(red:32/255,green:76/255,blue:156/255,alpha:1))
                    }
                }
                else{
                    colorArray[i].append(UIColor(red: 231/255, green: 174/255, blue: 95/255, alpha: 1))
                    colorOfEnableToMovePlace[0][i].append(UIColor(red: 243/255, green: 87/255, blue: 48/255, alpha: 1))
                    colorOfEnableToMovePlace[1][i].append( UIColor(red:116/255,green:87/255,blue:175/255,alpha:1))
                }
            }
        }

        drawKoma()
        
        
        // 持ち駒
        if( numOfGameMode == 1 ){
            for i in 0..<7{
                addMochiButtons(i: i)
            }
        }
        
        // キャスリングができるように再設定
        abilityOfCastlingWhiteLeft = true
        abilityOfCastlingWhiteRight = true
        abilityOfCastlingBlackLeft = true
        abilityOfCastlingBlackRight = true
        
        // 残り時間の描画
        switch numOfTimeMode {
        case 0:
            numberOfRemainingTimeMinuteG = 0
            numberOfRemainingTimeSecondG = 10
            break
            
        case 1:
            numberOfRemainingTimeMinuteG = 0
            numberOfRemainingTimeSecondG = 30
            break
            
        case 2:
            numberOfRemainingTimeMinuteG = 3
            numberOfRemainingTimeSecondG = 0
            break
            
        case 3:
            numberOfRemainingTimeMinuteG = 10
            numberOfRemainingTimeSecondG = 0
            break
            
        default:
            break
        }
        
        numberOfWhiteRemainingTimeMinuteG = numberOfRemainingTimeMinuteG
        numberOfBlackRemainingTimeMinuteG = numberOfRemainingTimeMinuteG
        numberOfWhiteRemainingTimeSecondG = numberOfRemainingTimeSecondG
        numberOfBlackRemainingTimeSecondG = numberOfRemainingTimeSecondG
        
    }
    
    func addButtonsAndImages(i: Int, j: Int){
        
        // buttonの生成
        
        // UIButtonのインスタンスを作成する
        let button = UIButton(type: UIButton.ButtonType.system)
        
        if(numOfMySide == 1){
            button.frame = CGRect(x: numOfWidthOfmarginG + numOfWidthOfSquareG * j , y: numOfheightOfmarginG + numOfWidthOfSquareG * i + (numOfTopMarginG - numOfBottomMarginG) / 3, width:numOfWidthOfSquareG, height:numOfWidthOfSquareG)
        }
        else{
            button.frame = CGRect(x: numOfWidthOfmarginG + numOfWidthOfSquareG * ( numOfSquare - 1 - j ) , y: numOfheightOfmarginG + numOfWidthOfSquareG * ( numOfSquare - 1 - i ) + (numOfTopMarginG - numOfBottomMarginG) / 3, width:numOfWidthOfSquareG, height:numOfWidthOfSquareG)
            if(numOfGameMode == 1){
                button.transform = button.transform.rotated(by: Double.pi.f)
            }
        }
        
        // ボタンを押した時に実行するメソッドを指定
        button.addTarget(self, action: #selector(buttonEvent(_:)), for: UIControl.Event.touchUpInside)
        
        button.alpha = numOfButtonAlpha.f
        
        if(numOfGameMode == 1 || numOfGameMode == 2){
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 1.0
        }
        
        // viewに追加する
        self.view.addSubview(button)
        button.tag = i * numOfSquare + j
        buttonArray[i].append(button)
        
    }
    
    // ボタンが押された時に呼ばれるメソッド
    @objc func buttonEvent(_ sender: UIButton) {
        let numOfPlaceY = sender.tag / numOfSquare
        let numOfPlaceX = sender.tag % numOfSquare
        if( (numOfTurn + 1) % 2 == numOfMySide % 2 ){
            tapped(numberOfX: numOfPlaceX, numberOfY: numOfPlaceY)
            
            if( isWantedToStartLoading ){
                isWantedToStartLoading = false
                if(isWantedToSelectPromotionG){
                    self.view.darkPromotion(numOfTurn)
                }
                sendTimerStart()
            }
        }
    }
    
    func addMochiButtons(i: Int){
        
        // buttonの生成
        
        // UIButtonのインスタンスを作成する
        let buttonWhite = UIButton(type: UIButton.ButtonType.system)
        let buttonBlack = UIButton(type: UIButton.ButtonType.system)
        let labelWhite = UILabel()
        let labelBlack = UILabel()
        
        buttonBlack.alpha = numOfButtonAlpha.f
        buttonWhite.alpha = numOfButtonAlpha.f

        buttonWhite.frame = CGRect(x: numOfWidthOfmarginG + numOfWidthOfSquareG * ( i + 1 ) , y: numOfheightOfmarginG + numOfWidthOfSquareG * 9 + (numOfTopMarginG - numOfBottomMarginG) / 3,
        width:numOfWidthOfSquareG, height:numOfWidthOfSquareG)
        
        buttonBlack.frame = CGRect(x: numOfWidthOfmarginG + numOfWidthOfSquareG * ( 7 - i ) , y: numOfheightOfmarginG - numOfWidthOfSquareG + (numOfTopMarginG - numOfBottomMarginG) / 3,
        width:numOfWidthOfSquareG, height:numOfWidthOfSquareG)
        
        // ボタンを押した時に実行するメソッドを指定
        buttonWhite.addTarget(self, action: #selector(mochiButtonEvent(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBlack.addTarget(self, action: #selector(mochiButtonEvent(_:)), for: UIControl.Event.touchUpInside)
        
        buttonWhite.setBackgroundImage(UIImage(named: String( 221 + i ) + ".png"), for: .normal)
        
        buttonBlack.setBackgroundImage(UIImage(named: String( 241 + i ) + ".png"), for: .normal)
        
        if(numOfMySide == 1){
            labelWhite.frame = CGRect(x: numOfWidthOfmarginG + numOfWidthOfSquareG * ( i + 1 ) , y: numOfheightOfmarginG + numOfWidthOfSquareG * 10 + (numOfTopMarginG - numOfBottomMarginG) / 3,width:numOfWidthOfSquareG, height:numOfWidthOfSquareG / 2)
            
            labelBlack.frame = CGRect(x: numOfWidthOfmarginG + numOfWidthOfSquareG * ( 7 - i ) , y: numOfheightOfmarginG - numOfWidthOfSquareG * 3 / 2 + (numOfTopMarginG - numOfBottomMarginG) / 3,width:numOfWidthOfSquareG, height:numOfWidthOfSquareG / 2)
            buttonWhite.tag = i
            buttonBlack.tag = i + 7
            labelBlack.transform = labelBlack.transform.rotated(by: Double.pi.f)
        }
        else{
            labelBlack.frame = CGRect(x: numOfWidthOfmarginG + numOfWidthOfSquareG * ( i + 1 ) , y: numOfheightOfmarginG + numOfWidthOfSquareG * 10 + (numOfTopMarginG - numOfBottomMarginG) / 3,width:numOfWidthOfSquareG, height:numOfWidthOfSquareG / 2)
            
            labelWhite.frame = CGRect(x: numOfWidthOfmarginG + numOfWidthOfSquareG * ( 7 - i ) , y: numOfheightOfmarginG - numOfWidthOfSquareG * 3 / 2 + (numOfTopMarginG - numOfBottomMarginG) / 3,width:numOfWidthOfSquareG, height:numOfWidthOfSquareG / 2)
            buttonWhite.tag = i + 7
            buttonBlack.tag = i
            labelWhite.transform = labelWhite.transform.rotated(by: Double.pi.f)
        }
        
        labelWhite.text = String(numOfMochiGomaWhite[i])
        labelBlack.text = String(numOfMochiGomaBlack[i])
        
        labelWhite.textAlignment = NSTextAlignment.center
        labelBlack.textAlignment = NSTextAlignment.center

        
        // viewに追加する
        self.view.addSubview(buttonWhite)
        self.view.addSubview(labelWhite)
        self.view.addSubview(buttonBlack)
        self.view.addSubview(labelBlack)
        mochiWhiteButtonAtrray.append(buttonWhite)
        mochiBlackButtonAtrray.append(buttonBlack)
        mochiWhiteLabelAtrray.append(labelWhite)
        mochiBlackLabelAtrray.append(labelBlack)
    }
    
    // ボタンが押された時に呼ばれるメソッド
    @objc func mochiButtonEvent(_ sender: UIButton) {
        let numOfkoma: Int = sender.tag % 7
        let side: Int = sender.tag / 7 + 1
        if(side != numOfMySide){
            return
        }
        if( numOfMode != 1 && numOfMode != 3 ){
            if( numOfReturnOfhecked < 2 ){
                if( side - 1 == numOfTurn % 2 ){
                    switch side {
                    case 1:
                        // numOfMode = 0 or 5
                        // 持ち駒をが選択された場合
                        if(numOfMode == 0){
                            if( numOfMochiGomaWhite[numOfkoma] != 0 ){
                                numOfMochiGomaWhite[numOfkoma] = numOfMochiGomaWhite[numOfkoma] - 1
                                mochiWhiteLabelAtrray[numOfkoma].text = String(numOfMochiGomaWhite[numOfkoma])
                                if( mochiGomaPut(side: side, koma: numOfkoma + 1) == 0 ){
                                    showAlertYT(titleYT: "注意", textYT: "持ち駒を置くことができません！", buttonsYT: ["OK"], numOfmodeYT: 0)
                                    numOfMochiGomaWhite[numOfkoma] = numOfMochiGomaWhite[numOfkoma] + 1
                                    mochiWhiteLabelAtrray[numOfkoma].text = String(numOfMochiGomaWhite[numOfkoma])
                                    drawKoma()
                                }
                                else{
                                    numOfMochiGomaId = 221 + numOfkoma
                                    numOfMode = 5
                                }
                            }
                        }
                            // 持ち駒選択の修正
                        else{
                            numOfMochiGomaWhite[numOfMochiGomaId % 10 - 1] = numOfMochiGomaWhite[numOfMochiGomaId % 10 - 1] + 1
                            mochiWhiteLabelAtrray[numOfMochiGomaId % 10 - 1].text = String(numOfMochiGomaWhite[numOfMochiGomaId % 10 - 1])
                            drawKoma()
                            // 同じのが選ばれた場合取り消し
                            if( numOfMochiGomaId % 10 - numOfkoma == 1 ){
                                numOfMode = 0
                            }
                            else{
                                if( numOfMochiGomaWhite[numOfkoma] != 0 ){
                                    numOfMochiGomaWhite[numOfkoma] = numOfMochiGomaWhite[numOfkoma] - 1
                                    mochiWhiteLabelAtrray[numOfkoma].text = String(numOfMochiGomaWhite[numOfkoma])
                                    if( mochiGomaPut(side: side, koma: numOfkoma + 1) == 0 ){
                                        showAlertYT(titleYT: "注意", textYT: "持ち駒を置くことができません！", buttonsYT: ["OK"], numOfmodeYT: 0)
                                        numOfMochiGomaWhite[numOfkoma] = numOfMochiGomaWhite[numOfkoma] + 1
                                        mochiWhiteLabelAtrray[numOfkoma].text = String(numOfMochiGomaWhite[numOfkoma])
                                        drawKoma()
                                    }
                                    else{
                                        numOfMochiGomaId = 221 + numOfkoma
                                        numOfMode = 5
                                    }
                                }
                            }
                        }
                        break
                        
                    case 2:
                        // numOfMode = 2 or 6
                        // 持ち駒をが選択された場合
                        if( numOfMode == 2 ){
                            if( numOfMochiGomaBlack[numOfkoma] != 0 ){
                                numOfMochiGomaBlack[numOfkoma] = numOfMochiGomaBlack[numOfkoma] - 1
                                mochiBlackLabelAtrray[numOfkoma].text = String(numOfMochiGomaBlack[numOfkoma])
                                if( mochiGomaPut(side: side, koma: numOfkoma + 1) == 0 ){
                                    showAlertYT(titleYT: "注意", textYT: "持ち駒を置くことができません！", buttonsYT: ["OK"], numOfmodeYT: 0)
                                    numOfMochiGomaBlack[numOfkoma] = numOfMochiGomaBlack[numOfkoma] + 1
                                    mochiBlackLabelAtrray[numOfkoma].text = String(numOfMochiGomaBlack[numOfkoma])
                                    drawKoma()
                                }
                                else{
                                    numOfMochiGomaId = 241 + numOfkoma
                                    numOfMode = 6
                                }
                            }
                        }
                            // 持ち駒選択の修正
                        else{
                            numOfMochiGomaBlack[numOfMochiGomaId % 10 - 1] = numOfMochiGomaBlack[numOfMochiGomaId % 10 - 1] + 1
                            mochiBlackLabelAtrray[numOfMochiGomaId % 10 - 1].text = String(numOfMochiGomaBlack[numOfMochiGomaId % 10 - 1])
                            drawKoma()
                            // 同じのが選ばれた場合取り消し
                            if( numOfMochiGomaId % 10 - numOfkoma == 1 ){
                                numOfMode = 2
                            }
                            else{
                                if( numOfMochiGomaBlack[numOfkoma] != 0 ){
                                    numOfMochiGomaBlack[numOfkoma] = numOfMochiGomaBlack[numOfkoma] - 1
                                    mochiBlackLabelAtrray[numOfkoma].text = String(numOfMochiGomaBlack[numOfkoma])
                                    if( mochiGomaPut(side: side, koma: numOfkoma + 1) == 0 ){
                                        showAlertYT(titleYT: "注意", textYT: "持ち駒を置くことができません！", buttonsYT: ["OK"], numOfmodeYT: 0)
                                        numOfMochiGomaBlack[numOfkoma] = numOfMochiGomaBlack[numOfkoma] + 1
                                        mochiBlackLabelAtrray[numOfkoma].text = String(numOfMochiGomaBlack[numOfkoma])
                                        drawKoma()
                                    }
                                    else{
                                        numOfMochiGomaId = 241 + numOfkoma
                                        numOfMode = 6
                                    }
                                }
                            }
                        }
                        break
                        
                    default:
                        break
                    }
                }
                else{
                    switch side {
                    case 1:
                        showAlertYT(titleYT: "注意", textYT: "後手の番です。", buttonsYT: ["OK"], numOfmodeYT: 0)
                        break
                        
                    case 2:
                        showAlertYT(titleYT: "注意", textYT: "先手の番です。", buttonsYT: ["OK"], numOfmodeYT: 0)
                        break
                        
                    default:
                        break
                    }
                }
            }
            else{
                showAlertYT(titleYT: "注意", textYT: "持ち駒では王手を防げません。王様を逃してください。", buttonsYT: ["OK"], numOfmodeYT: 0)
            }
        }
    }
    
    @IBAction func touryouPushed(){
        touryouAlert(numOfMySide)
        tellEnemyWin(2)
    }
    
    func remainTimerStart(){
        isMyTurn = true
        
        if numOfMode % 2 == 0 && numOfTimeMode < 2 && numOfLastTimeReseted != numOfTurn {
            numOfLastTimeReseted = numOfTurn
            numberOfWhiteRemainingTimeSecondG = numberOfRemainingTimeSecondG
            whiteTimeLabel.text = String(format: "%02d", numberOfWhiteRemainingTimeMinuteG) + ":" + String(format: "%02d", numberOfWhiteRemainingTimeSecondG)
        }
        
        // タイマーを開始するコード。一番引数が多いものを選ぶ。
        remainTimer = Timer.scheduledTimer(timeInterval: 1, target: self as Any, selector: #selector(self.timerMinus) , userInfo: nil, repeats: true)
    }
    
    @objc func timerMinus(){
        switch [numOfMode,numOfMySide] {
        case [0,1]:
            numberOfWhiteRemainingTimeSecondG -= 1
            if( numberOfWhiteRemainingTimeSecondG == -1 ){
                numberOfWhiteRemainingTimeSecondG = 59
                numberOfWhiteRemainingTimeMinuteG -= 1
            }
            if(numberOfWhiteRemainingTimeMinuteG == -1){
                remainTimer.invalidate()
                tellEnemyWin(1)
                timeOutAlert(2)
            }
            else{
                whiteTimeLabel.text = String(format: "%02d",numberOfWhiteRemainingTimeMinuteG) + ":" + String(format: "%02d",numberOfWhiteRemainingTimeSecondG)
                
            }
            break
            
        case [1,1]:
            numberOfWhiteRemainingTimeSecondG -= 1
            if( numberOfWhiteRemainingTimeSecondG == -1 ){
                numberOfWhiteRemainingTimeSecondG = 59
                numberOfWhiteRemainingTimeMinuteG -= 1
            }
            if(numberOfWhiteRemainingTimeMinuteG == -1){
                remainTimer.invalidate()
                tellEnemyWin(1)
                timeOutAlert(2)
            }
            else{
                whiteTimeLabel.text = String(format: "%02d",numberOfWhiteRemainingTimeMinuteG) + ":" + String(format: "%02d",numberOfWhiteRemainingTimeSecondG)
            }
            break
            
        case [2,2]:
            numberOfWhiteRemainingTimeSecondG -= 1
            if( numberOfWhiteRemainingTimeSecondG == -1 ){
                numberOfWhiteRemainingTimeSecondG = 59
                numberOfWhiteRemainingTimeMinuteG -= 1
            }
            if(numberOfWhiteRemainingTimeMinuteG == -1){
                remainTimer.invalidate()
                tellEnemyWin(1)
                timeOutAlert(1)
            }
            else{
                whiteTimeLabel.text = String(format: "%02d",numberOfWhiteRemainingTimeMinuteG) + ":" + String(format: "%02d",numberOfWhiteRemainingTimeSecondG)
            }
            break
            
        case [3,2]:
            numberOfWhiteRemainingTimeSecondG -= 1
            if( numberOfWhiteRemainingTimeSecondG == -1 ){
                numberOfWhiteRemainingTimeSecondG = 59
                numberOfWhiteRemainingTimeMinuteG -= 1
            }
            if(numberOfWhiteRemainingTimeMinuteG == -1){
                remainTimer.invalidate()
                tellEnemyWin(1)
                timeOutAlert(1)
            }
            else{
                whiteTimeLabel.text = String(format: "%02d",numberOfWhiteRemainingTimeMinuteG) + ":" + String(format: "%02d",numberOfWhiteRemainingTimeSecondG)
            }
            break
            
        case [5,1]:
            numberOfWhiteRemainingTimeSecondG -= 1
            if( numberOfWhiteRemainingTimeSecondG == -1 ){
                numberOfWhiteRemainingTimeSecondG = 59
                numberOfWhiteRemainingTimeMinuteG -= 1
            }
            if(numberOfWhiteRemainingTimeMinuteG == -1){
                remainTimer.invalidate()
                tellEnemyWin(1)
                timeOutAlert(2)
            }
            else{
                whiteTimeLabel.text = String(format: "%02d",numberOfWhiteRemainingTimeMinuteG) + ":" + String(format: "%02d",numberOfWhiteRemainingTimeSecondG)
            }
            break
            
        case [6,2]:
            numberOfWhiteRemainingTimeSecondG -= 1
            if( numberOfWhiteRemainingTimeSecondG == -1 ){
                numberOfWhiteRemainingTimeSecondG = 59
                numberOfWhiteRemainingTimeMinuteG -= 1
            }
            if(numberOfWhiteRemainingTimeMinuteG == -1){
                remainTimer.invalidate()
                tellEnemyWin(1)
                timeOutAlert(1)
            }
            else{
                whiteTimeLabel.text = String(format: "%02d",numberOfWhiteRemainingTimeMinuteG) + ":" + String(format: "%02d",numberOfWhiteRemainingTimeSecondG)
            }
            break
            
        default:
            break
        }
    }
    
    func loadTimerStart(){
        // タイマーを開始するコード。一番引数が多いものを選ぶ。
        isLoading = true
        loadTimer = Timer.scheduledTimer(timeInterval: 1, target: self as Any, selector: #selector(self.timerLoad) , userInfo: nil, repeats: true)
    }
    
    @objc func timerLoad(){
        numOfLoad = numOfLoad + 1
        // データの取得
        print("Loading >>",isAbleToChangePageG,numOfLoad)
        if(isAbleToChangePageG){
            let query = NCMBQuery(className: "Group")
            var memos = [NCMBObject]()
            var numOfNowSide: Int = 0
            var isEnemyTimeOut: Bool = false
            var isEnemyTouryou: Bool = false
            
            query?.whereKey("groupName", equalTo: groupNameG)
            query?.findObjectsInBackground({ (result, error) in
                if(error != nil){
                    // エラーが発生したら、
                    self.showAlertYT(titleYT: "エラー", textYT: error?.localizedDescription, buttonsYT: ["OK"], numOfmodeYT: 0)
                    self.dismiss(animated: true, completion: nil)
                }
                else{
                    // 読み込みが成功したら、
                    memos = result as! [NCMBObject]
                    if(memos.count != 0){
                        if( self.isLoading ){
                            numOfNowSide = memos[0].object(forKey: "numOfSide") as! Int
                            isEnemyTimeOut = memos[0].object(forKey: "isEnemyTimeOut") as! Bool
                            isEnemyTouryou = memos[0].object(forKey: "isEnemyTouryou") as! Bool
                            if( numOfNowSide == numOfMySide ){
                                self.isLoading = false
                                self.loadTimer.invalidate()
                                if( isEnemyTimeOut ){
                                    self.timeOutAlert(numOfMySide)
                                }
                                else if( isEnemyTouryou ){
                                    self.touryouAlert(3 - numOfMySide)
                                }
                                else{
                                    self.performSegue(withIdentifier: "NewGame", sender: nil)
                                }
                            }
                        }
                    }
                    else{
                        self.loadTimer.invalidate()
                        self.showAlertYT(titleYT: "エラー", textYT: "対戦相手との接続が切れました。", buttonsYT: ["OK"], numOfmodeYT: 0)
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            })
        }
    }
    
    func sendTimerStart(){
        sendTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self as Any, selector: #selector(self.timerSend) , userInfo: nil, repeats: true)
    }
    @objc func timerSend(){
        if isNotSellectingPromotionG{
            isWantedToSelectPromotionG = false
            sendTimer.invalidate()
            checkcheck()
//            printArray([4])
            upLoad()
        }
    }
    
    func upLoad() {
        statusMemoArrayG.removeAll()
        for i in 0..<numOfSquare {
            statusMemoArrayG.append([])
            for j in 0..<numOfSquare {
                statusMemoArrayG[i].append( statusArrayG[i][j].nOPA )
            }
        }
        var mochiMemoArray: [Int] = []
        for i in 0..<7 {
            mochiMemoArray.append(numOfMochiGomaWhite[i])
        }
        for i in 0..<7 {
            mochiMemoArray.append(numOfMochiGomaBlack[i])
        }
        let query = NCMBQuery(className: "Group")
        query?.whereKey("groupName", equalTo: groupNameG)
        query?.findObjectsInBackground({ (result, error) in
            if(error != nil){
                // エラーが発生したら、
                self.showAlertYT(titleYT: "エラー", textYT: error?.localizedDescription, buttonsYT: ["OK"], numOfmodeYT: 0)
                self.dismiss(animated: true, completion: nil)
            }
            else{
                // 読み込みが成功したら、
                self.remainTimer.invalidate()
                let memos = result as! [NCMBObject]
                if(memos.count != 0){
                    let textObject = memos[0]
                    textObject.setObject(statusMemoArrayG, forKey: "statusArray")
                    textObject.setObject(numOfEnPassant, forKey: "numOfEnPassant")
                    textObject.setObject(isUchiFu, forKey: "isUchiFu")
                    textObject.setObject(3 - numOfMySide, forKey: "numOfSide")
                    textObject.setObject([numberOfWhiteRemainingTimeMinuteG,numberOfWhiteRemainingTimeSecondG], forKey: "remainEnemyTime")
                    if(numOfGameMode == 1){
                        textObject.setObject(mochiMemoArray, forKey: "mochiMemoArray")
                    }
                    textObject.saveInBackground({ (error) in
                        if(error != nil){
                            // エラーが発生したら、
                            self.showAlertYT(titleYT: "エラー", textYT: error?.localizedDescription, buttonsYT: ["OK"], numOfmodeYT: 0)
                            self.dismiss(animated: true, completion: nil)                        }
                        else{
                            self.loadTimerStart()
                            self.view.showThinking(isRotate: false, mySide: numOfMySide)
                            self.view.bringSubviewToFront(self.touryouWhite)
                        }
                    })
                }
                else{
                    self.showAlertYT(titleYT: "エラー", textYT: "対戦相手との接続が切れました。", buttonsYT: ["OK"], numOfmodeYT: 0)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        })
        allTimerStop()
    }

    func tellEnemyWin(_ mode : Int){
        let query = NCMBQuery(className: "Group")
        query?.whereKey("groupName", equalTo: groupNameG)
        query?.findObjectsInBackground({ (result, error) in
            if(error != nil){
                // エラーが発生したら、
                self.showAlertYT(titleYT: "エラー", textYT: error?.localizedDescription, buttonsYT: ["OK"], numOfmodeYT: 0)
                self.dismiss(animated: true, completion: nil)
            }
            else{
                // 読み込みが成功したら、
                let memos = result as! [NCMBObject]
                if(memos.count != 0){
                    let textObject = memos[0]
                    if(mode == 1){
                        textObject.setObject(true, forKey: "isEnemyTimeOut")
                    }
                    else{
                        textObject.setObject(true, forKey: "isEnemyTouryou")
                    }
                    textObject.setObject(3 - numOfMySide, forKey: "numOfSide")
                    textObject.saveInBackground({ (error) in
                        if(error != nil){
                            // エラーが発生したら、
                            self.showAlertYT(titleYT: "エラー", textYT: error?.localizedDescription, buttonsYT: ["OK"], numOfmodeYT: 0)
                            self.dismiss(animated: true, completion: nil)
                        }
                    })
                }
                else{
                    self.showAlertYT(titleYT: "エラー", textYT: "対戦相手との接続が切れました。", buttonsYT: ["OK"], numOfmodeYT: 0)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        })
    }
}
