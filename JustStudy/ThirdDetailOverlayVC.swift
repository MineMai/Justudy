//
//  ThirdDetailOverlayVC.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/25.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class ThirdDetailOverlayVC: UIViewController {
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    
    @IBOutlet weak var courseLabel: UILabel!
    
    @IBOutlet weak var orderTimeLabel: UILabel!
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var comfornBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.bounds.size = CGSize(width: UIScreen.main.bounds.size.width - 110, height: 320)
        self.view.layer.cornerRadius = 10
        //littleView.layer.cornerRadius = 10
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backView.backgroundColor = UIColor.white
        
        backView.layer.cornerRadius = 20
        backView.layer.masksToBounds = true
        
        comfornBtn.layer.borderWidth = 1.0
        comfornBtn.layer.borderColor = UIColor.black.cgColor
        //comfornBtn.layer.cornerRadius = 5
        //comfornBtn.layer.masksToBounds = true
        cancelBtn.layer.borderWidth = 1.0
        cancelBtn.layer.borderColor = UIColor.black.cgColor
        //cancelBtn.layer.cornerRadius = 5
        //cancelBtn.layer.masksToBounds = true
        
        
        
    }
    
    
    @IBAction func comfirnBtn(_ sender: UIButton)
    {
        //消失彈跳視窗
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func cancelBtn(_ sender: UIButton)
    {
        //消失彈跳視窗
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    

    

    

}
















