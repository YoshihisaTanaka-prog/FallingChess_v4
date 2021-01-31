//
//  SetKindsOfGameViewController.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/08/17.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import UIKit

class SetKindsOfGameViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var label: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textView: UITextView!
//    titleLabel.alpha = numOfButtonAlpha.f
//    textView.alpha = numOfButtonAlpha.f
    
    var dataList:[String] = ["遊びたいゲームを選んでください。","チェス","将棋"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        pickerView.delegate = self
        pickerView.dataSource = self
        label.text = dataList[numOfGameMode + 1] + "を選択中"
        self.view.makeBackGround(isExistsNaviBar: true, isExistsTabBar: false)
        pickerView.alpha = numOfButtonAlpha.f
        label.alpha = numOfButtonAlpha.f
        titleLabel.alpha = numOfButtonAlpha.f
        textView.alpha = numOfButtonAlpha.f
        titleLabel.alpha = numOfButtonAlpha.f
        textView.alpha = numOfButtonAlpha.f
    }
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、要素の全数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.textAlignment = .center
        label.text = dataList[row]
        label.textColor = .black
        return label
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 処理
        if( row != 0 ){
            numOfGameMode = row - 1
            let ud = UserDefaults.standard
            ud.set( numOfGameMode , forKey: "numOfGameMode")
            ud.synchronize()
            label.text = dataList[numOfGameMode + 1] + "を選択中"
            backOfBackGroundImageG = UIImage(named: "BG" + String(numOfGameMode * 100 + numOfDesign + 100) + ".PNG")
            backGroundImageG = UIImage(named: "bg" + String(numOfGameMode * 100 + numOfDesign + 110) + ".png")
            self.view.makeBackGround(isExistsNaviBar: true, isExistsTabBar: false)
            wait5()
        }
    }

    var waitingTimer: Timer!
    var isStop = false
    func wait5(){
        waitingTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self as Any, selector: #selector(self.waiting) , userInfo: nil, repeats: true)
    }
    @objc func waiting(){
        if(isStop){
            waitingTimer.invalidate()
            self.navigationController?.popViewController(animated: true)
        }
        else{
            isStop = true
        }
    }
}
