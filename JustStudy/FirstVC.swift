//
//  FirstVC.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/20.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import SVProgressHUD

class FirstVC: UIViewController {
    
    @IBOutlet weak var signUpBtn: UIButton!
    
    lazy var session = { return URLSession(configuration: .default) }()
    
    var firstVCIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //移除返回鈕的文字
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        //self.tabBarController?.tabBar.isHidden = true
        
        
    }
    
    @IBAction func signUpBtn(_ sender: UIButton)
    {
        //showSuccessView()
        SVProgressHUD.show(withStatus: "處理中")
        SVProgressHUD.dismiss(withDelay: 1) {
            
            self.postData(id: activity[self.firstVCIndex].id!)
            
            let apply = BookedAct(schoolName: activity[self.firstVCIndex].location!, subject: activity[self.firstVCIndex].subject!, date: activity[self.firstVCIndex].date!, image: activity[self.firstVCIndex].image1!)
            
            bookedAct.append(apply)
            
            self.showSuccessView()
        }
        
        signUpBtn.setTitle("已報名", for: .normal)
        signUpBtn.tintColor = UIColor.white
        signUpBtn.backgroundColor = UIColor.darkGray
        signUpBtn.isEnabled = false
        
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
    
    
    
    
    func postData(id:Int)
    {
        let id = id
        let token = "Wnv3qgNZ6uy41pgXFYZT"
        if let url = URL(string: "http://api.justudy.tw/v1/activities/\(id)/participate?auth_token=\(token)")
        {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if error != nil
                {
                    print(error!.localizedDescription)
                }
                
                let json = try! JSONSerialization.jsonObject(with: data!, options: [])
                if let userData =  json as? [String:Any]
                {
                    if let mes = userData["message"]
                    {
                        print("mes = \(mes)")
                    }
                }
            })
            task.resume()
        }
    }
    
    
    
    
    

}











