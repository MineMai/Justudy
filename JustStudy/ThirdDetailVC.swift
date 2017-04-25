//
//  ThirdDetailVC.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/24.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class ThirdDetailVC: UIViewController {
    
    //給彈跳視窗用的
    let transitionDelegate = TransitionDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func orderSchoolBtn(_ sender: UIButton)
    {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let overlayVC = sb.instantiateViewController(withIdentifier: "ThirdDetailOverlayVC") as! ThirdDetailOverlayVC
        
        overlayVC.transitioningDelegate = transitionDelegate
        overlayVC.modalPresentationStyle = .custom
        self.present(overlayVC, animated: true, completion: nil)
        
    }
    

    
    

}









