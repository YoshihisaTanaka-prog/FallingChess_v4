//
//  TableViewCell.swift
//  falling_chess
//
//  Created by 田中義久 on 2020/09/14.
//  Copyright © 2020 Tanaka_Yoshihisa_4413. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var groupNameLabel: UILabel!
    @IBOutlet var gameModeLabel: UILabel!
    @IBOutlet var periodLabel: UILabel!
    @IBOutlet var remainTimeLabel: UILabel!
    @IBOutlet var isSucideLabel: UILabel!
    @IBOutlet var isJumpLabel: UILabel!
    @IBOutlet var isNoticeLabel: UILabel!
    @IBOutlet var view: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
