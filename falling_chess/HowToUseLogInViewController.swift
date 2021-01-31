//
//  HowToUseLogInViewController.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/09/13.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import UIKit

class HowToUseLogInViewController: UIViewController {
    
    let scrollView = UIScrollView()
    
    let titleArray: [String] = ["部屋の作り方(ホスト)","公開部屋への入り方(ゲスト)","秘密部屋への入り方(ゲスト)"]
    
    var passedNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.makeBackGround(isExistsNaviBar: true, isExistsTabBar: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //scrollViewの大きさを設定。
        scrollView.frame = self.view.frame
        
        //スクロール領域の設定
        scrollView.contentSize = CGSize(width: self.view.frame.width, height:1300)
        scrollView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        
        //scrollViewをviewのSubViewとして追加
        self.view.addSubview(scrollView)
        
        let titleView = UILabel()
        titleView.frame = CGRect(x:0,y:30,width:UIScreen.main.bounds.size.width ,height:40)
        titleView.textAlignment = NSTextAlignment.center
        titleView.backgroundColor = UIColor(red: 1, green: 1, blue: 0.8, alpha: 1)
        titleView.text = titleArray[passedNum]
        titleView.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        titleView.font = UIFont.systemFont(ofSize: 30)
        scrollView.addSubview(titleView)
        
        switch passedNum {
        case 0:
            let textView1 = UITextView()
            textView1.frame = CGRect(x: 10, y: 100, width: UIScreen.main.bounds.size.width - 20, height: 90)
            textView1.backgroundColor = UIColor(red: 1, green: 1, blue: 0.8, alpha: 1)
            textView1.text = "1. 部屋の名前（任意）を①に入力します。同じ名前の部屋が使用中の場合は名前を付け直す必要があります。"
            textView1.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            textView1.font = UIFont.systemFont(ofSize: 20)
            textView1.isEditable = false
            textView1.isSelectable = false
            scrollView.addSubview(textView1)
            
            let textView2 = UITextView()
            textView2.frame = CGRect(x: 10, y: 210, width: UIScreen.main.bounds.size.width - 20, height: 180)
            textView2.backgroundColor = UIColor(red: 1, green: 1, blue: 0.8, alpha: 1)
            textView2.text = "2. 部屋を非公開にする場合はパスワード（任意）を②と③(確認用)に入力して対戦相手に部屋の名前とパスワードを教えます。部屋を公開する場合は入力する必要がありません。"
            textView2.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            textView2.font = UIFont.systemFont(ofSize: 20)
            textView2.isEditable = false
            textView2.isSelectable = false
            scrollView.addSubview(textView2)
            
            let textView3 = UITextView()
            textView3.frame = CGRect(x: 10, y: 410, width: UIScreen.main.bounds.size.width - 20, height: 100)
            textView3.backgroundColor = UIColor(red: 1, green: 1, blue: 0.8, alpha: 1)
            textView3.text = "3. ④で部屋を公開するかどうか(緑色なら公開、灰色なら非公開)を決め、⑤をタップすることで部屋が作成されます。"
            textView3.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            textView3.font = UIFont.systemFont(ofSize: 20)
            textView3.isEditable = false
            textView3.isSelectable = false
            scrollView.addSubview(textView3)
            
            let textView4 = UITextView()
            textView4.frame = CGRect(x: 10, y: 530, width: UIScreen.main.bounds.size.width - 20, height: 100)
            textView4.backgroundColor = UIColor(red: 1, green: 1, blue: 0.8, alpha: 1)
            textView4.text = "注意：ゲームモードやルールなどは全てホスト側の設定で進行されます。"
            textView4.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            textView4.font = UIFont.systemFont(ofSize: 20)
            textView4.isEditable = false
            textView4.isSelectable = false
            scrollView.addSubview(textView4)
            
            let imageView = UIImageView(image: UIImage(named: "detail1.png"))
            let scale: CGFloat = (UIScreen.main.bounds.size.width - 20) / (UIImage(named: "detail1.png")?.size.width)!
            imageView.frame = CGRect(x: 10, y: 650, width: UIScreen.main.bounds.size.width - 20, height: (UIImage(named: "detail1.png")?.size.height)! * scale)
            imageView.layer.borderColor = UIColor.black.cgColor
            imageView.layer.borderWidth = 1.0
            scrollView.addSubview(imageView)
            break
            
        case 1:
            let textView1 = UITextView()
            textView1.frame = CGRect(x: 10, y: 100, width: UIScreen.main.bounds.size.width - 20, height: 80)
            textView1.backgroundColor = UIColor(red: 1, green: 1, blue: 0.8, alpha: 1)
            textView1.text = "1. ①の部分から自分の遊びたい条件の部屋を選択します。"
            textView1.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            textView1.font = UIFont.systemFont(ofSize: 20)
            textView1.isEditable = false
            textView1.isSelectable = false
            scrollView.addSubview(textView1)
            
            let textView2 = UITextView()
            textView2.frame = CGRect(x: 10, y: 200, width: UIScreen.main.bounds.size.width - 20, height: 80)
            textView2.backgroundColor = UIColor(red: 1, green: 1, blue: 0.8, alpha: 1)
            textView2.text = "2. リロードしたい場合には②をタップしてください。"
            textView2.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            textView2.font = UIFont.systemFont(ofSize: 20)
            textView2.isEditable = false
            textView2.isSelectable = false
            scrollView.addSubview(textView2)
            
            let textView3 = UITextView()
            textView3.frame = CGRect(x: 10, y: 300, width: UIScreen.main.bounds.size.width - 20, height: 150)
            textView3.backgroundColor = UIColor(red: 1, green: 1, blue: 0.8, alpha: 1)
            textView3.text = "3.リロードしても何も表示されない場合は部屋を作って他のプレイヤーが入ってくるまでお待ちください。部屋の作り方は「部屋の作り方」を参照してください。"
            textView3.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            textView3.font = UIFont.systemFont(ofSize: 20)
            textView3.isEditable = false
            textView3.isSelectable = false
            scrollView.addSubview(textView3)
            
            let textView4 = UITextView()
            textView4.frame = CGRect(x: 10, y: 470, width: UIScreen.main.bounds.size.width - 20, height: 100)
            textView4.backgroundColor = UIColor(red: 1, green: 1, blue: 0.8, alpha: 1)
            textView4.text = "注意：ゲームモードやルールなどは全てホスト側の設定で進行されます。"
            textView4.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            textView4.font = UIFont.systemFont(ofSize: 20)
            textView4.isEditable = false
            textView4.isSelectable = false
            scrollView.addSubview(textView4)
            
            let imageView = UIImageView(image: UIImage(named: "detail2.png"))
            let scale: CGFloat = (UIScreen.main.bounds.size.width - 20) / (UIImage(named: "detail2.png")?.size.width)!
            imageView.frame = CGRect(x: 10, y: 590, width: UIScreen.main.bounds.size.width - 20, height: (UIImage(named: "detail2.png")?.size.height)! * scale)
            imageView.layer.borderColor = UIColor.black.cgColor
            imageView.layer.borderWidth = 1.0
            scrollView.addSubview(imageView)
            break
            
        case 2:
            let textView1 = UITextView()
            textView1.frame = CGRect(x: 10, y: 100, width: UIScreen.main.bounds.size.width - 20, height: 80)
            textView1.backgroundColor = UIColor(red: 1, green: 1, blue: 0.8, alpha: 1)
            textView1.text = "1. ホストに非公開部屋の名前とパスワードを教えてもらいます。"
            textView1.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            textView1.font = UIFont.systemFont(ofSize: 20)
            textView1.isEditable = false
            textView1.isSelectable = false
            scrollView.addSubview(textView1)
            
            let textView2 = UITextView()
            textView2.frame = CGRect(x: 10, y: 200, width: UIScreen.main.bounds.size.width - 20, height: 100)
            textView2.backgroundColor = UIColor(red: 1, green: 1, blue: 0.8, alpha: 1)
            textView2.text = "2. ①に部屋名を入力して②にパスワードを入力したあとに③をタップしたら秘密の部屋に入ることができます。"
            textView2.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            textView2.font = UIFont.systemFont(ofSize: 20)
            textView2.isEditable = false
            textView2.isSelectable = false
            scrollView.addSubview(textView2)
            
            let textView4 = UITextView()
            textView4.frame = CGRect(x: 10, y: 320, width: UIScreen.main.bounds.size.width - 20, height: 80)
            textView4.backgroundColor = UIColor(red: 1, green: 1, blue: 0.8, alpha: 1)
            textView4.text = "注意：ゲームモードやルールなどは全てホスト側の設定で進行されます。"
            textView4.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            textView4.font = UIFont.systemFont(ofSize: 20)
            textView4.isEditable = false
            textView4.isSelectable = false
            scrollView.addSubview(textView4)
            
            let imageView = UIImageView(image: UIImage(named: "detail3.png"))
            let scale: CGFloat = (UIScreen.main.bounds.size.width - 20) / (UIImage(named: "detail3.png")?.size.width)!
            imageView.frame = CGRect(x: 10, y: 420, width: UIScreen.main.bounds.size.width - 20, height: (UIImage(named: "detail3.png")?.size.height)! * scale)
            imageView.layer.borderColor = UIColor.black.cgColor
            imageView.layer.borderWidth = 1.0
            scrollView.addSubview(imageView)
            break
            
        default:
            break
        }
    }
}
