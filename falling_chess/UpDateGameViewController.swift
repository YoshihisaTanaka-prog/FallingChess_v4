//
//  NewGameViewController.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/09/21.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import UIKit
import NCMB

class UpDateGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.makeBackGround(isExistsNaviBar: false, isExistsTabBar: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let query = NCMBQuery(className: "Group")
        var memos = [NCMBObject]()
        var numOfNowSide: Int = 0
        var remainTimeArray : [Int] = []
        var mochiMemoArray: [Int] = []
        
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
                    numOfNowSide = memos[0].object(forKey: "numOfSide") as! Int
                    if( numOfNowSide == numOfMySide ){

                        statusMemoArrayG = memos[0].object(forKey: "statusArray") as! [[Int]]
                        for i in 0..<numOfSquare{
                            for j in 0..<numOfSquare{
                                if(statusMemoArrayG[i][j] == 30){
                                    statusArrayG[i][j].iEATA = true
                                    if(numOfMySide == 2 && statusArrayG[i][j].nOPA != 30){
                                        buttonArray[i][j].transform = buttonArray[i][j].transform.rotated(by: Double.pi.f)
                                        colorArray[i][j] = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                                    }
                                }
                                else{
                                    statusArrayG[i][j].iEATA = false
                                }
                                statusArrayG[i][j].nOPA = statusMemoArrayG[i][j]
                                statusArrayG[i][j].offence = 0
                            }
                        }
                        if(numOfGameMode == 1){
                            mochiMemoArray = memos[0].object(forKey: "mochiMemoArray") as! [Int]
                            for i in 0..<7{
                                numOfMochiGomaWhite[i] = mochiMemoArray[i]
                                numOfMochiGomaBlack[i] = mochiMemoArray[i+7]
                                mochiWhiteLabelAtrray[i].text = String(numOfMochiGomaWhite[i])
                                mochiBlackLabelAtrray[i].text = String(numOfMochiGomaBlack[i])
                            }
                        }

                        remainTimeArray = memos[0].object(forKey: "remainEnemyTime") as! [Int]
                        numberOfBlackRemainingTimeMinuteG = remainTimeArray[0]
                        numberOfBlackRemainingTimeSecondG = remainTimeArray[1]

                        numOfEnPassant = memos[0].object(forKey: "numOfEnPassant") as! Int
                        isUchiFu = memos[0].object(forKey: "isUchiFu") as! Bool
                        
                        self.drawKoma()
                        if( numOfMySide == 1 ){
                            numOfMode = 0
                        }
                        else{
                            numOfMode = 2
                        }
                        numOfTurn = numOfTurn + 1
                        
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                else{
                    self.showAlertYT(titleYT: "エラー", textYT: "対戦相手との接続が切れました。", buttonsYT: ["OK"], numOfmodeYT: 0)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        })
    }
}
