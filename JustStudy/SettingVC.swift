//
//  SettingVC.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/27.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingVC: UIViewController {
    

    @IBOutlet weak var scanQR: UIButton!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if FIRAuth.auth()?.currentUser?.uid == "hGRNtRdLVLc8Dilgkytt7U0RMTi2"{
            scanQR.isHidden = false
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //指定menuBarButton的目標是側邊欄controller
        if revealViewController() != nil
        {
            menuBtn.target = revealViewController()
            menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        }
    }
    
    
    
    
    @IBAction func scanQRBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "scanView", sender: nil)
    }

    

}












