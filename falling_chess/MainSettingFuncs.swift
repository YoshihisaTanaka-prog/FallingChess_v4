//
//  MainSettingFuncs.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/09/17.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import Foundation
import UIKit

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
                    checkmateAlert()
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
                    checkmateAlert()
                }
            }
            else{
                stalemateAlert()
            }
        }
        else{
            holeAlert()
        }
    }
}
