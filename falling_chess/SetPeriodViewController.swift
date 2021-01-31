//
//  SetPeriodViewController.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/08/17.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import UIKit

class SetPeriodViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var dataList:[String] = ["周期を選択してください。","1","3","5","7","9","11"]
    let keepOfIsNotice: Bool = isNotice
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var label: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textView: UITextView!
    //    titleLabel.alpha = numOfButtonAlpha.f
    //    textView.alpha = numOfButtonAlpha.f
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        label.text = dataList[(numOfPeriod + 1) / 2] + "を選択中"
        
        self.view.makeBackGround(isExistsNaviBar: true, isExistsTabBar: false)
        pickerView.alpha = numOfButtonAlpha.f
        label.alpha = numOfButtonAlpha.f
        titleLabel.alpha = numOfButtonAlpha.f
        textView.alpha = numOfButtonAlpha.f
    }
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel(frame: CGRect(x: 0, y: 261, width: UIScreen.main.bounds.size.width, height: 216))
        label.textAlignment = .center
        label.text = dataList[row]
        label.textColor = .black
        return label
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if( row != 0 ){
            let ud = UserDefaults.standard
            ud.set(2 * row - 1 ,forKey: "numOfPeriod")
            numOfPeriod = 2 * row - 1
            if( numOfPeriod == 1 ){
                ud.set(false,forKey: "isNotice")
                isNotice = false
            }
            else{
                ud.set(keepOfIsNotice,forKey: "isNotice")
                isNotice = keepOfIsNotice
            }
            ud.synchronize()
            label.text = dataList[(numOfPeriod + 1) / 2] + "を選択中"
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
