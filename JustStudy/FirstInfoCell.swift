//
//  FirstInfoCell.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/23.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class FirstInfoCell: UITableViewCell {
    
    @IBOutlet weak var firstInfoTopic: UILabel!
    
    @IBOutlet weak var firstInfoTime: UILabel!
    
    @IBOutlet weak var firstInfoPlaceBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
