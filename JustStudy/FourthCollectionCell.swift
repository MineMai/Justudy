//
//  FourthCollectionCell.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/20.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class FourthCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var heroImage: UIImageView!
    
    @IBOutlet weak var heroBackImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let layer = heroImage?.layer
        layer?.cornerRadius = 100
        layer?.masksToBounds = true
        
    }
    
}
