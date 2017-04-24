//
//  MyActivityVC.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/22.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class MyActivityVC: UIViewController {
    
    @IBOutlet weak var ActLikeContainer: UIView!
    
    @IBOutlet weak var ActOrderContainer: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        ActLikeContainer.isHidden = false
        ActOrderContainer.isHidden = true
        
    }

    
    @IBAction func segment(_ sender: UISegmentedControl)
    {
        switch sender.selectedSegmentIndex
        {
            case 0:
                ActLikeContainer.isHidden = false
                ActOrderContainer.isHidden = true
            case 1:
                ActLikeContainer.isHidden = true
                ActOrderContainer.isHidden = false
            default:
                break
        }
    }
    

}












