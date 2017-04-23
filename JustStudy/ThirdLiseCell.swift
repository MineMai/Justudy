//
//  ThirdLiseCell.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/23.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class ThirdLiseCell: UITableViewCell {
    
    @IBOutlet weak var lisenceTopic: UILabel!
    
    @IBOutlet weak var lisenceSchool: UILabel!
    
    @IBOutlet weak var lisencePlace: UILabel!
    
    @IBOutlet weak var lisenceKind: UILabel!
    
    @IBOutlet weak var lisenceLikeBtn: DOFavoriteButton!
    
    
    @IBOutlet weak var lisenceImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
