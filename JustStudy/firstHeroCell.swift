//
//  firstHeroCell.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/22.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class firstHeroCell: UITableViewCell {
    
    @IBOutlet weak var heroImage: UIImageView!
    
    @IBOutlet weak var heroImageTopConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
