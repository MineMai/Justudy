//
//  ThirdDescriptionCell.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/23.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class ThirdDescriptionCell: UITableViewCell {
    
    @IBOutlet weak var licenseLabel: UILabel!
    
    @IBOutlet weak var licenseDesLabel: UILabel!
    
    @IBOutlet weak var licenseImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
