//
//  Variables.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/08/17.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import Foundation
import UIKit


var buttonArray:[[UIButton]] = []
var colorArray:[[UIColor]] = []
var colorOfEnableToMovePlace:[[[UIColor]]] = [[],[]]
var abilityOfCastlingWhiteLeft: Bool = true
var abilityOfCastlingWhiteRight: Bool = true
var abilityOfCastlingBlackLeft: Bool = true
var abilityOfCastlingBlackRight: Bool = true

var userName: String = ""
var numOfPeriod: Int = 0
var numOfTimeMode: Int = 0
var numOfGameMode: Int = 0
var numOfDesign: Int = 0
var numOfButtonAlpha: Float = 0.9
var isSucide: Bool = true
var isJump: Bool = true
var isNotice: Bool = true
var isNegative: Bool = false
var isOpen: Bool = false
var isFirstTime: Bool = false
var isShowBanchi: Bool = true

var isOnLine: Bool = false
var numOfMySide: Int = 1
var groupNameG: String = ""
var timerG: Timer!
var isWaiting: Bool = true
var isPlaying: Bool = false
var isWantedToStartLoading: Bool = false
var isAbleToChangePageG: Bool = true
var isWantedToSelectPromotionG: Bool = false
var isNotSellectingPromotionG: Bool = true

var numOfShuffledArray:[Int] = []

var mochiWhiteButtonAtrray: [UIButton] = []
var mochiBlackButtonAtrray: [UIButton] = []
var mochiWhiteLabelAtrray: [UILabel] = []
var mochiBlackLabelAtrray: [UILabel] = []
var numOfMochiGomaWhite:[Int] = [0,0,0,0,0,0,0]
var numOfMochiGomaBlack:[Int] = [0,0,0,0,0,0,0]

var numberOfPlaceX: Int = 0
var numberOfPlaceY: Int = 0
var numberOfPlaceNextX: Int = 0
var numberOfPlaceNextY: Int = 0
var numOfSquare: Int = 0
var numOfMode: Int = 0
var numOfTurn: Int = 0
var numOfMochiGomaId: Int = 0
var numOfReturnOfhecked: Int = 0
var numOfChoice: Int = 1
var isUchiFu: Bool = false
var numOfEnPassant: Int = -1
var numOfWhenAlertG: Int = 1
var numOfLastHoleAlertedG: Int = 0

var numOfWidthOfSquareG: Int = 0
var numOfWidthOfmarginG: Int = 0
var numOfheightOfmarginG: Int = 0
var numOfTopMarginG: Int = 0
var numOfBottomMarginG: Int = 0

var numberOfRemainingTimeMinuteG: Int = 10
var numberOfRemainingTimeSecondG: Int = 0

var numberOfWhiteRemainingTimeMinuteG: Int = 0
var numberOfWhiteRemainingTimeSecondG: Int = 0
var numberOfBlackRemainingTimeMinuteG: Int = 0
var numberOfBlackRemainingTimeSecondG: Int = 0

class Status: NSObject{
    var nOPA: Int // numOfPresentArray
    var iATM: Bool // isAbleToMove
    var defence: Int
    var offence: Int
    var iEATA: Bool // isEnemyAbleToAttack
    init(nOPA: Int, iATM: Bool, defence: Int, offence: Int, iEATA: Bool){
        self.nOPA = nOPA
        self.iATM = iATM
        self.defence = defence
        self.offence = offence
        self.iEATA = iEATA
    }
}
var statusMemoArrayG: [[Int]] = []
var statusArrayG: [[Status]] = []

var defaultChessArrayG: [[Int]] = [
    [142,143,144,145,148,144,143,142],
    [141,141,141,141,141,141,141,141],
    [  0,  0,  0,  0,  0,  0,  0,  0],
    [  0,  0,  0,  0,  0,  0,  0,  0],
    [  0,  0,  0,  0,  0,  0,  0,  0],
    [  0,  0,  0,  0,  0,  0,  0,  0],
    [121,121,121,121,121,121,121,121],
    [122,123,124,125,128,124,123,122]
]
var defaultShogiArrayG: [[Int]] = [
    [242,243,244,245,248,245,244,243,242],
    [  0,247,  0,  0,  0,  0,  0,246,  0],
    [241,241,241,241,241,241,241,241,241],
    [  0,  0,  0,  0,  0,  0,  0,  0,  0],
    [  0,  0,  0,  0,  0,  0,  0,  0,  0],
    [  0,  0,  0,  0,  0,  0,  0,  0,  0],
    [221,221,221,221,221,221,221,221,221],
    [  0,226,  0,  0,  0,  0,  0,227,  0],
    [222,223,224,225,228,225,224,223,222]
]
var defaultMakrukArrayG: [[Int]] = [
    [342,343,344,345,348,345,344,343],
    [  0,  0,  0,  0,  0,  0,  0,  0],
    [341,341,341,341,341,341,341,341],
    [  0,  0,  0,  0,  0,  0,  0,  0],
    [  0,  0,  0,  0,  0,  0,  0,  0],
    [321,321,321,321,321,321,321,321],
    [  0,  0,  0,  0,  0,  0,  0,  0],
    [322,323,324,328,325,324,323,322]
]
var defaultChaturangaArrayG: [[Int]] = [
    [452,453,454,455,458,454,453,452],
    [442,443,444,445,448,444,443,442],
    [  0,  0,  0,  0,  0,  0,  0,  0],
    [  0,  0,  0,  0,  0,  0,  0,  0],
    [  0,  0,  0,  0,  0,  0,  0,  0],
    [  0,  0,  0,  0,  0,  0,  0,  0],
    [422,423,424,428,425,424,423,422],
    [432,433,434,438,435,434,433,432]
]

var chessBanchiG:[String] = [
    "a8","b8","c8","d8","e8","f8","g8","h8",
    "a7","b7","c7","d7","e7","f7","g7","h7",
    "a6","b6","c6","d6","e6","f6","g6","h6",
    "a5","b5","c5","d5","e5","f5","g5","h5",
    "a4","b4","c4","d4","e4","f4","g4","h4",
    "a3","b3","c3","d3","e3","f3","g3","h3",
    "a2","b2","c2","d2","e2","f2","g2","h2",
    "a1","b1","c1","d1","e1","f1","g1","h1"
]

var shogiBanchiG:[String] = [
    "9一","8一","7一","6一","5一","4一","3一","2一","1一",
    "9二","8二","7二","6二","5二","4二","3二","2二","1二",
    "9三","8三","7三","6三","5三","4三","3三","2三","1三",
    "9四","8四","7四","6四","5四","4四","3四","2四","1四",
    "9五","8五","7五","6五","5五","4五","3五","2五","1五",
    "9六","8六","7六","6六","5六","4六","3六","2六","1六",
    "9七","8七","7七","6七","5七","4七","3七","2七","1七",
    "9八","8八","7八","6八","5八","4八","3八","2八","1八",
    "9九","8九","7九","6九","5九","4九","3九","2九","1九"
]

var banchiG:[String] = []

var backOfBackGroundImageG = UIImage(named: "BG" + String(numOfGameMode * 100 + numOfDesign + 100) + ".PNG")
var backGroundImageG = UIImage(named: "bg" + String(numOfGameMode * 100 + numOfDesign + 110) + ".png")

var colorListG: [[UIColor]] = [[
        UIColor(red: 1, green: 178/255, blue: 154/255, alpha: 1),
        UIColor(red: 1, green: 1, blue: 0, alpha: 1),
        UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1),
        UIColor(red:175/255,green:223/255,blue:228/255,alpha:1)
    ],[
        UIColor(red: 0.5, green: 0, blue: 0, alpha: 1),
        UIColor(red: 192/255, green: 96/255, blue: 0, alpha: 1),
        UIColor(red: 0, green: 0, blue: 0, alpha: 1),
        UIColor(red: 0, green: 0, blue: 0.5, alpha: 1)
    ]]

var cgOfTopMarginListG: [CGFloat] = [0.f,0.f]
var cgOfBottomMarginListG: [CGFloat] = [0.f,0.f]
var numOfGettingMarginFirst = 0

class SaveStatus: NSObject{
    var saveData: [[[Int]]]
    var num: [Int]
    
    init(saveData: [[[Int]]], num: [Int]){
        self.saveData = saveData
        self.num = num
    }
    
    func isThousand() -> Bool {
        var statusMemo: [[Int]] = []
        
        for i in 0..<statusArrayG.count {
            statusMemo.append([])
            for j in 0..<statusArrayG[i].count{
                statusMemo[i].append(statusArrayG[i][j].nOPA)
            }
        }
        
        self.saveData.append(statusMemo)
        self.num.append(0)
        
        for i in 0..<self.saveData.count {
            if self.num[i] > 0 || i == self.saveData.count - 1 {
                if(self.saveData[i] == statusMemo){
                    self.num[i] += 1
                    if self.num[i] == 3 {
                        return true
                    }
                    break
                }
            }
        }
        print(self.num)
        
        return false
    }
}
var saveStatus = SaveStatus(saveData: [], num: [])
