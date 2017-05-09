//
//  ThirdDetailVC.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/24.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class ThirdDetailVC: UIViewController, OrderBtnStatus {
    
    
    @IBOutlet weak var orderSchoolBtn: UIButton!
    
    var detailVCKind = 0
    var detailVCIndex = 0
    
    //給彈跳視窗用的
    let transitionDelegate = TransitionDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //移除返回鈕的文字
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        //print(detailVCKind)
        //print(detailVCIndex)
    }

    
    @IBAction func orderSchoolBtn(_ sender: UIButton)
    {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let overlayVC = sb.instantiateViewController(withIdentifier: "ThirdDetailOverlayVC") as! ThirdDetailOverlayVC
        overlayVC.btnStatusDelege = self
        overlayVC.transitioningDelegate = transitionDelegate
        overlayVC.modalPresentationStyle = .custom
        overlayVC.overlayKind = detailVCKind
        overlayVC.overlayIndex = detailVCIndex
        self.present(overlayVC, animated: true, completion: nil)
        
    }
    
    func changeBtnStatus()
    {
        orderSchoolBtn.setTitle("已預約", for: .normal)
        orderSchoolBtn.tintColor = UIColor.white
        orderSchoolBtn.backgroundColor = UIColor.darkGray
        orderSchoolBtn.isEnabled = false
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ThirdTableViewSegue"
        {
            let vc = segue.destination as! ThirdDetailTbvc
            vc.detailTbvcKind = detailVCKind
            vc.detailTbvcIndex = detailVCIndex
            
        }
    }
    
    
    

}









