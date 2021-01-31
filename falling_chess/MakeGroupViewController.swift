//
//  MakeGroupViewController.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/09/13.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import UIKit
import NCMB

class MakeGroupViewController: UIViewController {

    @IBOutlet var groupNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmTextField: UITextField!
    @IBOutlet var uiSwitch: UISwitch!
    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!
    
    var isVargin: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        UITabBar.appearance().backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        
        // Do any additional setup after loading the view.
        uiSwitch.isOn = isOpen
        
        numOfShuffledArray.removeAll()
        switch numOfGameMode {
        case 1:
            numOfSquare = 9
        default:
            numOfSquare = 8
        }
        for i in 0..<numOfSquare{
            for j in 0..<numOfSquare {
                numOfShuffledArray.append( i * numOfSquare + j )
            }
        }
        groupNameTextField.alpha = numOfButtonAlpha.f
        passwordTextField.alpha = numOfButtonAlpha.f
        confirmTextField.alpha = numOfButtonAlpha.f
        uiSwitch.alpha = numOfButtonAlpha.f
        label.alpha = numOfButtonAlpha.f
        button.alpha = numOfButtonAlpha.f
    }
    
    override func viewWillAppear(_ animated: Bool) {
        alertControllersYT.removeAll()
        self.view.makeBackGround(isExistsNaviBar: true, isExistsTabBar: true)
        groupNameTextField.text = ""
        passwordTextField.text = ""
        confirmTextField.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        isVargin = true
    }
    
    @IBAction func makeGroup(){
        if( groupNameTextField.text != nil && ( passwordTextField.text != nil || isOpen ) && isVargin ){
            isVargin = false
            if((groupNameTextField.text)!.count > 3 && passwordTextField.text == confirmTextField.text){
                
                let query = NCMBQuery(className: "Group")
                query?.whereKey("groupName", equalTo: groupNameTextField.text)
                query?.findObjectsInBackground({ (result, error) in
                    if(error != nil){
                        // エラーが発生したら、
                        self.showAlertYT(titleYT: "エラー", textYT: error?.localizedDescription, buttonsYT: ["OK"], numOfmodeYT: 0)
                    }
                    else{
                        // 読み込みが成功したら、
                        let messages = result as! [NCMBObject]
                        if messages.count == 0 {
                            groupNameG = self.groupNameTextField.text!
                            let object = NCMBObject(className: "Group")
                            object?.setObject(self.groupNameTextField.text, forKey: "groupName")
                            if( isOpen == false ){
                                object?.setObject(self.passwordTextField.text, forKey: "password")
                            }
                            object?.setObject(1, forKey: "numOfMembers")
                            object?.setObject(numOfGameMode,forKey: "numOfGameMode")
                            object?.setObject(numOfPeriod,forKey: "numOfPeriod")
                            object?.setObject(numOfTimeMode,forKey: "numOfTimeMode")
                            object?.setObject(isSucide,forKey: "isSucide")
                            object?.setObject(isJump,forKey: "isJump")
                            object?.setObject(isNotice,forKey: "isNotice")
                            object?.setObject(1,forKey: "numOfSide")
                            
                            switch numOfGameMode {
                            case 0:
                                object?.setObject( defaultChessArrayG ,forKey: "statusArray")
                                
                            case 1:
                                object?.setObject( defaultShogiArrayG ,forKey: "statusArray")
                                
                            case 2:
                                object?.setObject( defaultChessArrayG ,forKey: "statusArray")
                                
                            case 3:
                                object?.setObject( defaultChessArrayG ,forKey: "statusArray")
                                
                            default:
                                break
                            }
                            
                            switch numOfTimeMode {
                            case 0:
                                object?.setObject( [0,10] ,forKey: "remainEnemyTime")
                                
                            case 1:
                                object?.setObject( [0,30] ,forKey: "remainEnemyTime")
                                
                            case 2:
                                object?.setObject( [3,0] ,forKey: "remainEnemyTime")
                                
                            case 3:
                                object?.setObject( [10,0] ,forKey: "remainEnemyTime")
                                
                            default:
                                break
                            }
                            
                            if self.uiSwitch.isOn {
                                object?.setObject(true, forKey: "isOpen")
                                let ud = UserDefaults.standard
                                ud.set(true,forKey: "isOpen")
                                isOpen = true
                            }
                            else{
                                object?.setObject(false, forKey: "isOpen")
                                let ud = UserDefaults.standard
                                ud.set(false,forKey: "isOpen")
                                isOpen = false
                            }
                            
                            self.shuffle()
                            
                            object?.setObject(numOfShuffledArray,forKey: "numOfShuffledArray")
                            
                            numOfMySide = rand(minYT: 1, maxYT: 2)
                            object?.setObject(numOfMySide,forKey: "numOfHostSide")
                            object?.setObject(numOfEnPassant,forKey: "numOfEnPassant")

                            object?.setObject(false,forKey: "isEnemyTimeOut")
                            object?.setObject(false,forKey: "isEnemyTouryou")
                            object?.setObject(isUchiFu, forKey: "isUchiFu")
                            
                            object?.saveInBackground({ (error) in
                                if(error != nil){
                                    // エラーが発生したら、
                                    self.showAlertYT(titleYT: "エラー", textYT: error?.localizedDescription, buttonsYT: ["OK"], numOfmodeYT: 0)
                                }
                            })
                            self.performSegue(withIdentifier: "ToWaitingRoom", sender: nil)
                        }
                        else{

                            self.showAlertYT(titleYT: "エラー", textYT: "部屋名「" + self.groupNameTextField.text! + "」はあります。", buttonsYT: ["OK"], numOfmodeYT: 0)
                            self.isVargin = true
                        }
                    }
                })
            }
        }
    }
}
