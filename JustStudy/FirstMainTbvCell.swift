//
//  FirstMainTbvCell.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/20.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class FirstMainTbvCell: UITableViewCell {
    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var firstTopicLabel: UILabel!
    @IBOutlet weak var firstTimeLabel: UILabel!
    @IBOutlet weak var firstPlaceLabel: UILabel!
    @IBOutlet weak var firstLikeBtn: DOFavoriteButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //firstLikeBtn.addTarget(self, action: #selector(likeTapped(sender:)), for: .touchUpInside)
        
    }
    
//    func likeTapped(sender: DOFavoriteButton) {
//        if sender.isSelected {
//            // deselect
//            sender.deselect()
//        } else {
//            // select with animation
//            sender.select()
//        }
//    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}












