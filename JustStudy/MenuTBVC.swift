//
//  MenuTBVC.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/16.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class MenuTBVC: UITableViewController {
    
    @IBOutlet weak var menuAvatar: UIImageView!
    
    @IBOutlet weak var menuName: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuAvatar.layer.cornerRadius = 35
        menuAvatar.layer.borderWidth = 1.0
        menuAvatar.layer.borderColor = UIColor.white.cgColor
        menuAvatar.clipsToBounds = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //如果是用FB登入的才去載FB的照片名字
        if isFBLogin
        {
            menuName.text = fbUsers?.name
            menuAvatar.image = try! UIImage(data: Data(contentsOf: (fbUsers?.pictureURL)!))
        }
        else if isGoogleLogin
        {
            menuName.text = googleUsers?.name
            menuAvatar.image = try! UIImage(data: Data(contentsOf: (googleUsers?.pictureURL)!))
        }
        else
        {
            menuName.text = sideProfileName
            menuAvatar.image = sideProfileImage
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "logOutSegue"
        {
            FBSDKLoginManager().logOut()
            GIDSignIn.sharedInstance().signOut()
            if FireBaseHandler.Instance.logOut()
            {
                isFBLogin = false
                isGoogleLogin = false
                print("已登出Firebase帳號")
            }
            else
            {
                alertTheUser(title: "登出異常", message: "現在無法登出，請稍候再試")
            }
        }
    }

    func alertTheUser(title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }

    
    
    

}













