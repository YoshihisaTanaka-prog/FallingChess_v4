//
//  DesignViewController.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/09/13.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import UIKit

class DesignViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let pickerTitle: [[String]] = [["以下から選んでください。","女王","司教","騎士","城"],["以下から選んでください。","姫君","神主","武士","城"]]
    
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textView: UITextView!
    
    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    let swich = UISwitch()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        self.view.makeBackGround(isExistsNaviBar: true, isExistsTabBar: false)
        pickerView.alpha = numOfButtonAlpha.f
        titleLabel.alpha = numOfButtonAlpha.f
        textView.alpha = numOfButtonAlpha.f
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let ud = UserDefaults.standard
        ud.set(numOfButtonAlpha, forKey: "numOfButtonAlpha")
        ud.synchronize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 0.5
        slider.value = 1 - numOfButtonAlpha
        slider.frame = CGRect(x: view.frame.width * 0.1, y: 470, width: view.frame.width * 0.8, height: 20)
        slider.addTarget(self, action: #selector(reWrite), for: .valueChanged)
        slider.alpha = numOfButtonAlpha.f
        self.view.addSubview(slider)
        
        label1.text = "濃い"
        label2.text = "薄い"
        label3.text = "座標を表示する"
        label1.frame = CGRect(x: view.frame.width * 0.1 - 20, y: 520, width: 40, height: 30)
        label2.frame = CGRect(x: view.frame.width * 0.9 - 20, y: 520, width: 40, height: 30)
        label3.frame = CGRect(x: view.frame.width * 0.1 - 20, y: 600, width: view.frame.width * 0.6 + 40, height: 50)
        swich.frame = CGRect(x: view.frame.width * 0.9 - 20, y: 600, width: 40, height: 50)
        label1.textAlignment = NSTextAlignment.center
        label2.textAlignment = NSTextAlignment.center
        label3.textAlignment = NSTextAlignment.center
        switch numOfGameMode {
        case 0:
            label1.backgroundColor = UIColor(red:61/255,green:150/255,blue:56/255,alpha:1)
            label2.backgroundColor = UIColor(red:227/255,green:225/255,blue:186/255,alpha:1)
            break
            
        case 1:
            label1.backgroundColor = UIColor(red: 231/255, green: 174/255, blue: 95/255, alpha: 1)
            label2.backgroundColor = UIColor(red: 231/255, green: 174/255, blue: 95/255, alpha: 1)
            break
            
        default:
            break
        }
        label3.backgroundColor = .white
        swich.backgroundColor = .white
        swich.isOn = isShowBanchi
        swich.addTarget(self, action: #selector(changeSwitch), for: UIControl.Event.valueChanged)
        label3.font = label3.font.withSize(30)
        label1.alpha = numOfButtonAlpha.f
        label2.alpha = numOfButtonAlpha.f
        label3.alpha = numOfButtonAlpha.f
        swich.alpha = numOfButtonAlpha.f
        self.view.addSubview(label1)
        self.view.addSubview(label2)
        self.view.addSubview(label3)
        self.view.addSubview(swich)
        
    }
    
    @objc func reWrite(_ sender: UISlider){
        numOfButtonAlpha = 1 - sender.value
        label1.alpha = numOfButtonAlpha.f
        label2.alpha = numOfButtonAlpha.f
        label3.alpha = numOfButtonAlpha.f
        swich.alpha = numOfButtonAlpha.f
        pickerView.alpha = numOfButtonAlpha.f
        titleLabel.alpha = numOfButtonAlpha.f
        textView.alpha = numOfButtonAlpha.f
        self.navigationController?.navigationBar.alpha = numOfButtonAlpha.f
    }
    
    @objc func changeSwitch(sender: UISwitch){
        let ud = UserDefaults.standard
        if(sender.isOn){
            isShowBanchi = true
            ud.set(isShowBanchi, forKey: "isShowBanchi")
        }
        else{
            isShowBanchi = false
            ud.set(isShowBanchi, forKey: "isShowBanchi")
        }
        ud.synchronize()
    }
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerTitle[numOfGameMode].count
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel(frame: CGRect(x: 0, y: 261, width: UIScreen.main.bounds.size.width, height: 216))
        label.textAlignment = .center
        label.text = pickerTitle[numOfGameMode][row]
        label.textColor = .black
        return label
    }

    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if( row != 0 ){
            numOfDesign = row
            let ud = UserDefaults.standard
            ud.set(numOfDesign,forKey: "numOfDesign")
            ud.synchronize()
            
            let namebb = "BG" + String(numOfGameMode * 100 + numOfDesign + 100) + ".PNG"
            let nameb = "bg" + String(numOfGameMode * 100 + numOfDesign + 110) + ".png"
            
            backOfBackGroundImageG = UIImage(named: namebb)
            backGroundImageG = UIImage(named:  nameb)
//            print(namebb,backOfBackGroundImageG)
//            print(nameb,backGroundImageG)
            self.navigationController?.navigationBar.barTintColor = colorListG[0][numOfDesign - 1]
            self.navigationController?.navigationBar.tintColor = colorListG[1][numOfDesign - 1]
            
            self.view.makeBackGround(isExistsNaviBar: true, isExistsTabBar: false)
        }
    }
}
