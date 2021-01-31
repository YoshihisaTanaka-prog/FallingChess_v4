//
//  AdvertiseTableViewCell.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/10/15.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import UIKit

class AdvertiseTableViewCell: UITableViewCell {
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var AdImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let AdImage = UIImage(named: "please.png")
        messageLabel.adjustsFontSizeToFitWidth = true
        AdImageView.image = AdImage
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
