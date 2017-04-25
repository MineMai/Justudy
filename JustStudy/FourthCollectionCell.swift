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
    
    @IBOutlet weak var heroNameLabel: UILabel!
    
    @IBOutlet weak var heroTopicLabel: UILabel!
    
    @IBOutlet weak var heroBackView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let layer = heroImage?.layer
        layer?.cornerRadius = 90
        layer?.masksToBounds = true
        
//        let layer2 = heroBackImage?.layer
//        layer2?.cornerRadius = 20
//        layer2?.masksToBounds = true
//        
//        let layer3 = effectView?.layer
//        layer3?.cornerRadius = 20
//        layer3?.masksToBounds = true
//        layer3?.borderWidth = 1.0
//        layer3?.borderColor = UIColor.white.cgColor
        
        heroBackView.layer.borderWidth = 2.0
        heroBackView.layer.borderColor = UIColor.white.cgColor
        
        
    }
    
}









