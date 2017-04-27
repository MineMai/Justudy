//
//  ChatEnterVC.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/26.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChatEnterVC: UIViewController {
    
    @IBOutlet weak var serviceImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //大頭照圓型
        let layer = serviceImage?.layer
        layer?.cornerRadius = 50
        layer?.masksToBounds = true
    }
    
    @IBAction func chatEnterButton(_ sender: UIButton) {
        
        //頁面判斷
        
        if FIRAuth.auth()?.currentUser?.uid == "hGRNtRdLVLc8Dilgkytt7U0RMTi2"{
            self.performSegue(withIdentifier: "manager", sender: nil)
        }else{
            self.performSegue(withIdentifier: "member", sender: nil)
        }
    
    }
    
    

    

}


















