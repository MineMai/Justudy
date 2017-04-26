//
//  ChatEnterVC.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/26.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class ChatEnterVC: UIViewController {
    
    @IBOutlet weak var serviceImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //大頭照圓型
        let layer = serviceImage?.layer
        layer?.cornerRadius = 50
        layer?.masksToBounds = true
        
        
    }
    
    

    

}


















