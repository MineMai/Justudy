//
//  SignUpVC.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/16.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import SVProgressHUD

class SignUpVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var signUpAvatar: UIImageView!
    
    @IBOutlet weak var signUpEmail: UITextField!
    
    @IBOutlet weak var signUpPassword: UITextField!
    
    @IBOutlet weak var signUpName: UITextField!
    
    @IBOutlet weak var signUpBtn: UIButton!
    
    
    var avatar:UIImage?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //註冊鈕外觀
        signUpBtn.layer.borderWidth = 1.0
        signUpBtn.layer.borderColor = UIColor.white.cgColor
        
        //大頭照圓型
        let layer = signUpAvatar?.layer
        layer?.cornerRadius = 80
        layer?.masksToBounds = true
        
        //在圖片上加入點擊手勢效果
        signUpAvatar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfileImage)))
        
    }
    
    
    @IBAction func signUpBtn(_ sender: UIButton)
    {
        if signUpEmail.text != "" && signUpPassword.text != "" && avatar != nil && signUpName.text != ""
        {
            SVProgressHUD.show(withStatus: "上傳中")
            //存資料與圖片
            let uidString = NSUUID().uuidString
            let usersAvatar = FireBaseHandler.Instance.storageRef.child("Users_avatar").child(uidString)
            let imageData:Data = UIImageJPEGRepresentation(self.signUpAvatar.image!, 0.4)!
            usersAvatar.put(imageData, metadata: nil) { (metadata, error) in
                if error != nil
                {
                    print("上傳大頭錯誤: \(error?.localizedDescription ?? "")")
                    return
                }
                
                //database儲存位置
                let avatarURL:String = (metadata?.downloadURL()?.absoluteString)!
                FireBaseHandler.Instance.signUp(email: self.signUpEmail.text!, password: self.signUpPassword.text!, name: self.signUpName.text!, avatarURL: avatarURL, loginHandler: { (message) in
                    
                    if message != nil
                    {
                        self.alertTheUser(title: "註冊異常", message: message!)
                    }
                    else
                    {
                        //清空輸入欄
                        self.signUpEmail.text = ""
                        self.signUpPassword.text = ""
                        self.signUpName.text = ""
                        self.avatar = UIImage(named: "profile_picture.png")
                        //註冊成功要跳轉換頁
                        SVProgressHUD.dismiss()
                        self.performSegue(withIdentifier: "SignupSegue", sender: nil)
                    }
                })
            }
        }
        else
        {
            alertTheUser(title: "尚未填入", message: "請輸入完整資訊")
        }
        
    }

    @IBAction func goBackBtn(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
    //手勢點擊選照片
    func selectProfileImage()
    {
        print("pressed")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        show(imagePickerController, sender: self)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        avatar = info[UIImagePickerControllerOriginalImage] as? UIImage
        signUpAvatar.image = avatar
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //Alert Function
    func alertTheUser(title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    //文字框按下return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    

}













