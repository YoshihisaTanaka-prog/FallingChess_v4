//
//  GameViewController.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/08/17.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import UIKit

class GameViewController: UIViewController{

    @IBOutlet var whiteTimeLabel: UILabel!
    @IBOutlet var blackTimeLabel: UILabel!
    @IBOutlet var touryouWhite: UIButton!
    @IBOutlet var touryouBlack: UIButton!
    
    var numOfLastHoleAlerted: Int = 0
    var numOfLastTimeReseted: Int = 0
    var numOfNowSide: Int = 1
    
    var stopTimer: Timer!
    
    // 読み込まれた時の処理
    override func viewDidLoad() {
        super.viewDidLoad()
        isOnLine = false
        whiteTimeLabel.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        blackTimeLabel.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.view.makeBackGround(isExistsNaviBar: false, isExistsTabBar: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        self.view.fusumaFirst(isOpen: true, isExistsNavigationBar: false, isExistsTabBar: false)
        first()
//        self.hideToFusuma(isExistsNaviBar: false, isExistsTabBar: false)
//        self.view.openFusuma(isExistsNaviBar: false, isExistsTabBar: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        self.view.closeFusuma(isExistsNaviBar: false, isExistsTabBar: false)
        
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
        
        timerG.invalidate()
        if(isNotSellectingPromotionG == false){
            stopTimer.invalidate()
        }
        
        statusArrayG.removeAll()
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
        numOfShuffledArray.removeAll()
        
        saveStatus.saveData.removeAll()
        saveStatus.num.removeAll()
    }
    
    func addButtonsAndImages(i: Int, j: Int){
        
        // buttonの生成
        
        // UIButtonのインスタンスを作成する
        let button = UIButton(type: UIButton.ButtonType.system)

        button.frame = CGRect(x: numOfWidthOfmarginG + numOfWidthOfSquareG * j , y: numOfheightOfmarginG + numOfWidthOfSquareG * i + (numOfTopMarginG - numOfBottomMarginG) / 3,
        width:numOfWidthOfSquareG, height:numOfWidthOfSquareG)
        
        // ボタンを押した時に実行するメソッドを指定
        button.addTarget(self, action: #selector(buttonEvent(_:)), for: UIControl.Event.touchUpInside)

        
        if(numOfGameMode == 1 || numOfGameMode == 2){
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 1.0
        }
        
        // viewに追加する
        self.view.addSubview(button)
        button.tag = i * numOfSquare + j
        button.alpha = numOfButtonAlpha.f
        buttonArray[i].append(button)
        
    }
    // ボタンが押された時に呼ばれるメソッド
    @objc func buttonEvent(_ sender: UIButton) {
        let numOfPlaceY = sender.tag / numOfSquare
        let numOfPlaceX = sender.tag % numOfSquare
        tapped(numberOfX: numOfPlaceX, numberOfY: numOfPlaceY)
        
        if numOfMode % 2 == 0 && numOfLastTimeReseted != numOfTurn {            if(isWantedToSelectPromotionG){
                self.view.darkPromotion(numOfTurn)
            }
            stopTimerStart()
            if(numOfTimeMode < 2){
                numberOfWhiteRemainingTimeMinuteG = numberOfRemainingTimeMinuteG
                numberOfWhiteRemainingTimeSecondG = numberOfRemainingTimeSecondG
                numberOfBlackRemainingTimeMinuteG = numberOfRemainingTimeMinuteG
                numberOfBlackRemainingTimeSecondG = numberOfRemainingTimeSecondG
                whiteTimeLabel.text = String(format: "%02d", numberOfWhiteRemainingTimeMinuteG) + ":" + String(format: "%02d", numberOfWhiteRemainingTimeSecondG)
                blackTimeLabel.text = String(format: "%02d", numberOfBlackRemainingTimeMinuteG) + ":" + String(format: "%02d", numberOfBlackRemainingTimeSecondG)
            }
        }
    }
    
    @IBAction func toryouWhiteAction(){
        if( numOfMode < 2 || numOfMode == 5 ){
            timerG.invalidate()
            touryouAlert(1)
        }
    }
    
    @IBAction func toryouBlackAction(){
        if( numOfMode > 1 && numOfMode != 5 ){
            timerG.invalidate()
            touryouAlert(2)
        }
    }
    
    func addMochiButtons(i: Int){
        
        // buttonの生成
        
        // UIButtonのインスタンスを作成する
        let buttonWhite = UIButton(type: UIButton.ButtonType.system)
        let buttonBlack = UIButton(type: UIButton.ButtonType.system)
        let labelWhite = UILabel()
        let labelBlack = UILabel()

        buttonWhite.alpha = numOfButtonAlpha.f
        buttonBlack.alpha = numOfButtonAlpha.f
        
        buttonWhite.frame = CGRect(x: numOfWidthOfmarginG + numOfWidthOfSquareG * ( i + 1 ) , y: numOfheightOfmarginG + numOfWidthOfSquareG * 9 + (numOfTopMarginG - numOfBottomMarginG) / 3,
        width:numOfWidthOfSquareG, height:numOfWidthOfSquareG)
        
        buttonBlack.frame = CGRect(x: numOfWidthOfmarginG + numOfWidthOfSquareG * ( 7 - i ) , y: numOfheightOfmarginG - numOfWidthOfSquareG + (numOfTopMarginG - numOfBottomMarginG) / 3,
        width:numOfWidthOfSquareG, height:numOfWidthOfSquareG)
        
        // ボタンを押した時に実行するメソッドを指定
        buttonWhite.addTarget(self, action: #selector(mochiButtonEvent(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBlack.addTarget(self, action: #selector(mochiButtonEvent(_:)), for: UIControl.Event.touchUpInside)
        
        buttonWhite.setBackgroundImage(UIImage(named: String( 221 + i ) + ".png"), for: .normal)
        
        buttonBlack.setBackgroundImage(UIImage(named: String( 241 + i ) + ".png"), for: .normal)
        
        
        labelWhite.frame = CGRect(x: numOfWidthOfmarginG + numOfWidthOfSquareG * ( i + 1 ) , y: numOfheightOfmarginG + numOfWidthOfSquareG * 10 + (numOfTopMarginG - numOfBottomMarginG) / 3,
                                  width:numOfWidthOfSquareG, height:numOfWidthOfSquareG / 2)
        
        labelBlack.frame = CGRect(x: numOfWidthOfmarginG + numOfWidthOfSquareG * ( 7 - i ) , y: numOfheightOfmarginG - numOfWidthOfSquareG * 3 / 2 + (numOfTopMarginG - numOfBottomMarginG) / 3,
                                  width:numOfWidthOfSquareG, height:numOfWidthOfSquareG / 2)
        labelWhite.text = String(numOfMochiGomaWhite[i])
        labelBlack.text = String(numOfMochiGomaBlack[i])
        
        labelWhite.textAlignment = NSTextAlignment.center
        labelBlack.textAlignment = NSTextAlignment.center
        labelBlack.transform = labelBlack.transform.rotated(by: Double.pi.f)
        buttonWhite.tag = i
        buttonBlack.tag = i + 7

        
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
    
    func first(){
        numOfMode = 0
        numOfTurn = 0
        numOfReturnOfhecked = 0
        numOfChoice = 1
        isUchiFu = false
        numOfEnPassant = -1
        numOfLastHoleAlertedG = 0
        numOfMySide = 1
        
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
                numOfShuffledArray.append( i*numOfSquare + j )
            }
        }
        shuffle()
        
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
        saveStatus.isThousand()
        
        // 将棋の場合に持ち駒を表示する
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
        // 次の画面の変数にこの画面の変数を入れている
        whiteTimeLabel.text = String(format: "%02d", numberOfWhiteRemainingTimeMinuteG) + ":" + String(format: "%02d", numberOfWhiteRemainingTimeSecondG)
        blackTimeLabel.text = String(format: "%02d", numberOfBlackRemainingTimeMinuteG) + ":" + String(format: "%02d", numberOfBlackRemainingTimeSecondG)
        blackTimeLabel.transform = blackTimeLabel.transform.rotated(by: Double.pi.f)
        touryouBlack.transform = touryouBlack.transform.rotated(by: Double.pi.f)
        timerStart()
    }

    // 残り時間を計算する関数たち
    func timerStart(){
        // タイマーを開始するコード。一番引数が多いものを選ぶ。
        timerG = Timer.scheduledTimer(timeInterval: 1, target: insteadOfSelfYT() as Any, selector: #selector(self.timerMinus) , userInfo: nil, repeats: true)
        
    }
    
    @objc func timerMinus(){
//        print("timerMinus >>",numOfNowSide)
        switch numOfNowSide {
//        case 0:
//            numberOfWhiteRemainingTimeSecondG -= 1
//            if( numberOfWhiteRemainingTimeSecondG == -1 ){
//                numberOfWhiteRemainingTimeSecondG = 59
//                numberOfWhiteRemainingTimeMinuteG -= 1
//            }
//            if(numberOfWhiteRemainingTimeMinuteG == -1){
//                timerG.invalidate()
//                timeOutAlert(2)
//            }
//            else{
//                whiteTimeLabel.text = String(format: "%02d",numberOfWhiteRemainingTimeMinuteG) + ":" + String(format: "%02d",numberOfWhiteRemainingTimeSecondG)
//            }
//            break
            
        case 1:
            numberOfWhiteRemainingTimeSecondG -= 1
            if( numberOfWhiteRemainingTimeSecondG == -1 ){
                numberOfWhiteRemainingTimeSecondG = 59
                numberOfWhiteRemainingTimeMinuteG -= 1
            }
            if(numberOfWhiteRemainingTimeMinuteG == -1){
                timerG.invalidate()
                timeOutAlert(2)
            }
            else{
                whiteTimeLabel.text = String(format: "%02d",numberOfWhiteRemainingTimeMinuteG) + ":" + String(format: "%02d",numberOfWhiteRemainingTimeSecondG)
            }
            break
        
        case 2:
            numberOfBlackRemainingTimeSecondG -= 1
            if( numberOfBlackRemainingTimeSecondG == -1 ){
                numberOfBlackRemainingTimeSecondG = 59
                numberOfBlackRemainingTimeMinuteG -= 1
            }
            if(numberOfBlackRemainingTimeMinuteG == -1){
                timerG.invalidate()
                timeOutAlert(1)
            }
            else{
                blackTimeLabel.text = String(format: "%02d",numberOfBlackRemainingTimeMinuteG) + ":" + String(format: "%02d",numberOfBlackRemainingTimeSecondG)
            }
//            break
//
//        case 3:
//            numberOfBlackRemainingTimeSecondG -= 1
//            if( numberOfBlackRemainingTimeSecondG == -1 ){
//                numberOfBlackRemainingTimeSecondG = 59
//                numberOfBlackRemainingTimeMinuteG -= 1
//
//            }
//            if(numberOfBlackRemainingTimeMinuteG == -1){
//                timerG.invalidate()
//                timeOutAlert(1)
//            }
//            else{
//                blackTimeLabel.text = String(format: "%02d",numberOfBlackRemainingTimeMinuteG) + ":" + String(format: "%02d",numberOfBlackRemainingTimeSecondG)
//            }
//            break
//
//        case 5:
//            numberOfWhiteRemainingTimeSecondG -= 1
//            if( numberOfWhiteRemainingTimeSecondG == -1 ){
//                numberOfWhiteRemainingTimeSecondG = 59
//                numberOfWhiteRemainingTimeMinuteG -= 1
//            }
//            if(numberOfWhiteRemainingTimeMinuteG == -1){
//                timerG.invalidate()
//                timeOutAlert(2)
//            }
//            else{
//                whiteTimeLabel.text = String(format: "%02d",numberOfWhiteRemainingTimeMinuteG) + ":" + String(format: "%02d",numberOfWhiteRemainingTimeSecondG)
//            }
//            break
//
//        case 6:
//            numberOfBlackRemainingTimeSecondG -= 1
//            if( numberOfBlackRemainingTimeSecondG == -1 ){
//                numberOfBlackRemainingTimeSecondG = 59
//                numberOfBlackRemainingTimeMinuteG -= 1
//
//            }
//            if(numberOfBlackRemainingTimeMinuteG == -1){
//                timerG.invalidate()
//                timeOutAlert(1)
//            }
//            else{
//                blackTimeLabel.text = String(format: "%02d",numberOfBlackRemainingTimeMinuteG) + ":" + String(format: "%02d",numberOfBlackRemainingTimeSecondG)
//            }
//            break
            
        default:
            break
        }
    }
    
    func stopTimerStart(){
        // タイマーを開始するコード。一番引数が多いものを選ぶ。
        stopTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self as Any, selector: #selector(self.timerStop) , userInfo: nil, repeats: true)
        
    }
    
    @objc func timerStop(){
//        print("timerStop >>",isNotSellectingPromotionG)
        if isNotSellectingPromotionG{
            isWantedToSelectPromotionG = false
            stopTimer.invalidate()
            drawKoma()
            checkcheck()
            numOfNowSide = 3 - numOfNowSide
            numOfLastTimeReseted = numOfTurn
            printArray([0])
        }
    }
}
