//
//  ThirdDetailHeroCell.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/24.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class ThirdDetailHeroCell: UITableViewCell {
    
    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var detailTopic: UILabel!
    
    @IBOutlet weak var detailSchool: UILabel!
    
    @IBOutlet weak var detailPlace: UILabel!
    
    @IBOutlet weak var detailKind: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
