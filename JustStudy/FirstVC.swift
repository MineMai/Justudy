//
//  FirstVC.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/20.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class FirstVC: UIViewController {
    
    
    var firstVCIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        //self.tabBarController?.tabBar.isHidden = true
        
        
    }
    
    @IBAction func signUpBtn(_ sender: UIButton)
    {
        showSuccessView()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableViewSegue"
        {
            let vc = segue.destination as! FirstDetailTbvc
            vc.detailIndex = firstVCIndex
        }
    }
    
    

    //MARK: - 製作動畫視窗
    func showSuccessView()
    {
        let viewHeight = view.frame.height / 14
        let viewY = 0 - viewHeight
        let successView = UIView(frame: CGRect(x: 0, y: viewY, width: view.frame.width, height: viewHeight))
        successView.backgroundColor = UIColor(red:1.00, green:0.91, blue:0.54, alpha:1.0)
        view.addSubview(successView)
        
        let label = UILabel()
        label.frame.size.width = successView.frame.width
        label.frame.size.height = successView.frame.height
        label.text = "報名成功！"
        label.textColor = UIColor(red:0.28, green:0.18, blue:0.97, alpha:1.0)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        successView.addSubview(label)
        
        UIView.animate(withDuration: 0.3, animations: { 
            
            successView.frame.origin.y = 64
        }) { (finished) in
            if finished
            {
                UIView.animate(withDuration: 0.2, delay: 2.0, options: .curveEaseInOut, animations: {
                    
                    successView.frame.origin.y = viewY
                }, completion: { (finished) in
                    if finished
                    {
                        successView.removeFromSuperview()
                    }
                })
            }
            
        }
    }
    
    
    
    

}











