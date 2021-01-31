//
//  OriginalButtons.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/10/15.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import Foundation
import UIKit

class OriginalButton: UIButton{
    
    func makeButton(size: CGFloat, titles: [String], num: Int){
        self.frame = CGRect(x: 0, y: 0, width: size * 7 / 2, height: size)
        self.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: 2.f * num.f * size + size + cgOfTopMarginListG[1])
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2.0
        var nameArray:[String] = []
        for c in titles[num]{
            nameArray.append(String(c))
        }
        switch nameArray.count {
        case 2:
            nameArray.insert(contentsOf: [" "," "], at: 1)
            nameArray.insert(contentsOf: [" "," "], at: 0)
            nameArray.append(contentsOf: [" "," "])
            break
            
        case 3:
            nameArray.append(" ")
            nameArray.insert(" ", at: 2)
            nameArray.insert(" ", at: 1)
            nameArray.insert(" ", at: 0)
            break
            
        case 4:
            nameArray.insert(contentsOf: [" "," "], at: 0)
            nameArray.append(contentsOf: [" "," "])
            break
            
        default:
            nameArray.insert(" ", at: 0)
            nameArray.append(" ")
            break
        }
        
        for i in 0..<nameArray.count {
            let label = UILabel()
            let view0 = UIImageView()
            let view1 = UIView()
            let view2 = UIView()
            let x: CGFloat = (i.f - 3.f + ( 14 - nameArray.count ).f / 2 - 1 / 2 ) * size / 2
            view0.frame = CGRect(x: x , y: size / 4, width: size / 2, height: size / 2)
            view1.frame = CGRect(x: x , y: -1 * size / 4, width: size / 2, height: size / 2)
            view2.frame = CGRect(x: x , y: 3 * size / 4, width: size / 2, height: size / 2)
            label.frame = CGRect(x: 0, y: 0, width: size / 2, height: size / 2)
            label.text = nameArray[i]
            label.textAlignment = .center
            switch numOfGameMode {
            case 0:
                label.font = UIFont.boldSystemFont(ofSize: size * 2 / 5)
                if( i % 2 == 0 ){
                    view0.backgroundColor = UIColor(red:227/255,green:225/255,blue:186/255,alpha:1)
                    view1.backgroundColor = UIColor(red:61/255,green:150/255,blue:56/255,alpha:1)
                    view2.backgroundColor = UIColor(red:61/255,green:150/255,blue:56/255,alpha:1)
                    label.textColor = .black
                }
                else{
                    view0.backgroundColor = UIColor(red:61/255,green:150/255,blue:56/255,alpha:1)
                    view1.backgroundColor = UIColor(red:227/255,green:225/255,blue:186/255,alpha:1)
                    view2.backgroundColor = UIColor(red:227/255,green:225/255,blue:186/255,alpha:1)
                    label.textColor = .white
                }
                break
                
            case 1:
//                label.font = label.font.withSize(size / 3)
                label.font = UIFont(name: "KouzanBrushFontGyousyoOTF", size: size / 3)
                view0.backgroundColor = UIColor(red: 231/255, green: 174/255, blue: 95/255, alpha: 1)
                view1.backgroundColor = UIColor(red: 231/255, green: 174/255, blue: 95/255, alpha: 1)
                view2.backgroundColor = UIColor(red: 231/255, green: 174/255, blue: 95/255, alpha: 1)
                
                view0.layer.borderColor = UIColor.black.cgColor
                view1.layer.borderColor = UIColor.black.cgColor
                view2.layer.borderColor = UIColor.black.cgColor
                
                view0.layer.borderWidth = 1.0
                view1.layer.borderWidth = 1.0
                view2.layer.borderWidth = 1.0
                if(nameArray[i] != " "){
                    view0.image = UIImage(named: "1.png")
                }
                label.textColor = .black
                break
                
            default:
                break
            }
            
            view0.addSubview(label)
            self.addSubview(view0)
            self.addSubview(view1)
            self.addSubview(view2)
        }
    }
}
