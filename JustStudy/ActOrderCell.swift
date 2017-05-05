//
//  ActOrderCell.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/24.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class ActOrderCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var actOrderTitle: UILabel!
    
    @IBOutlet weak var actOrderSubtitle: UILabel!
    
    @IBOutlet weak var buttonLabel: UILabel!
    
    
    @IBOutlet weak var imageCoverView: UIView!
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        let featuredHeight = ZoomingLayoutConstants.Cell.featuredHeight
        let standardHeight = ZoomingLayoutConstants.Cell.standardHeight
        
        let delta = 1 - ((featuredHeight - frame.height) / (featuredHeight - standardHeight))
        
        let minAlpha: CGFloat = 0.15
        let maxAlpha: CGFloat = 0.75
        
        imageCoverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        
        let scale = max(delta, 0.5)
        actOrderTitle.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        actOrderSubtitle.alpha = delta
        //placeLabel.alpha = delta
    }
    
}
