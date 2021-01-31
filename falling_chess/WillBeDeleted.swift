//
//  WillBeDeleted.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/10/03.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import Foundation
import UIKit

func printArray(_ mode: [Int]){
    var memoArray = [[String]]()
    
    for modeI in mode{
        switch modeI {
        case 0:
            // nOPA
            for i in 0..<numOfSquare {
                memoArray.append([])
                for j in 0..<numOfSquare{
                    memoArray[i].append(String(format: "%3d", statusArrayG[i][j].nOPA))
                }
            }
            print("nOPA >>")
            break
            
        case 1:
            // iATM
            for i in 0..<numOfSquare {
                memoArray.append([])
                for j in 0..<numOfSquare{
                    if(statusArrayG[i][j].iATM){
                        memoArray[i].append(" T ")
                    }
                    else{
                        memoArray[i].append(" F ")
                    }
                }
            }
            print("iATM >>")
            break
            
        case 2:
            // defence
            for i in 0..<numOfSquare {
                memoArray.append([])
                for j in 0..<numOfSquare{
                    memoArray[i].append(String(format: "%3d", statusArrayG[i][j].defence))
                }
            }
            print("defence >>")
            break
            
        case 3:
            // offence
            for i in 0..<numOfSquare {
                memoArray.append([])
                for j in 0..<numOfSquare{
                    memoArray[i].append(String(format: "%3d", statusArrayG[i][j].offence))
                }
            }
            print("offence >>")
            break
            
            
        case 4:
            // iEATA
            for i in 0..<numOfSquare {
                memoArray.append([])
                for j in 0..<numOfSquare{
                    if(statusArrayG[i][j].iEATA){
                        memoArray[i].append(" T ")
                    }
                    else{
                        memoArray[i].append(" F ")
                    }
                }
            }
            print("iEATA >>")
            break
            
        default:
            break
        }
        
        for line in memoArray{
            print(line)
        }
        
        memoArray.removeAll()
    }
}
