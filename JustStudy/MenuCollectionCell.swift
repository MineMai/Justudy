//
//  MenuCollectionCell.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/18.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class MenuCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var menuIcon: UIImageView!
    
    override var isHighlighted: Bool {
        didSet {
            menuIcon.tintColor = isHighlighted ? UIColor.white : UIColor(red: 0.356, green: 0.054, blue: 0.05, alpha: 1.0)
        }
    }
    override var isSelected: Bool {
        didSet {
            menuIcon.tintColor = isSelected ? UIColor.white : UIColor(red: 0.356, green: 0.054, blue: 0.05, alpha: 1.0)
        }
    }
    
    
}
