//
//  LoginVC.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/15.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import GoogleSignIn
import SVProgressHUD


class LoginVC: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var orImageView: UIImageView!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    
    
    //用來存放從FB and Google取來的個資 
    var FBdata:[String:Any]?
    var googledata:[String:Any]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Firebase的登入註冊鈕外觀
        loginBtn.layer.borderWidth = 1.0
        loginBtn.layer.borderColor = UIColor(red:0.74, green:0.76, blue:0.78, alpha:1.0).cgColor
        loginBtn.layer.cornerRadius = 10
        
        //設定Google 登入鈕
        GIDSignIn.sharedInstance().uiDelegate = self //要記得簽Google協定
        GIDSignIn.sharedInstance().delegate = self
        
        //設定轉轉
        SVProgressHUD.setDefaultStyle(.light) //轉轉小方框的 亮暗
        SVProgressHUD.setDefaultMaskType(.black) //轉轉背景的 亮暗
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //檢查有沒有使用者，有的話就直接進入，要在didAppear才有作用
        checkLogin()
    }
    
    
    //MARK: - firebaseLogin
    @IBAction func loginBtn(_ sender: UIButton)
    {
        if emailTextField.text != "" && passwordTextField.text != ""
        {
            FireBaseHandler.Instance.logIn(email: emailTextField.text!, password: passwordTextField.text!, loginHandler: { (message) in
                
                if message != nil
                {
                    self.alertTheUser(title: "登入異常", message: message!)
                }
                else
                {
                    self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                }
            })
        }
        else
        {
            alertTheUser(title: "尚未填入", message: "請輸入Email與Password")
        }
        
    }
    
    @IBAction func forgotBtn(_ sender: UIButton)
    {
        
        
    }
    
    //MARK: - FB Button
    @IBAction func fbLoginBtn(_ sender: UIButton)
    {
        // 使用FBSDKLoginManager的方法
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, err) in
            
            if err != nil
            {
                print("FB Login failed:",err ?? "")
                return
            }
            self.showFBUserMsg()
        }
    }
    
    
    //MARK: - 簽完FB協定後要實作方法
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("已登出FB")
    }
    
    
    func showFBUserMsg()
    {
        SVProgressHUD.show(withStatus: "登入中")
        let parameters = ["fields":"email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: { (connection, result, error) in
            
            if error != nil
            {
                print(error ?? "")
                SVProgressHUD.dismiss()
                return
            }
            if let results = result as? NSDictionary
            {
                guard let email = results["email"] else { return }
                
                print("email = \(email)")
                
                guard let firstName = results["first_name"] as? String, let lastName = results["last_name"] as? String else { return }
                
                let name = firstName + " " + lastName
                print("name = \(name)")
                
                guard let picture = results["picture"] as? NSDictionary, let data = picture["data"] as? NSDictionary, let url = data["url"] as? String else { return }
                print("URL = \(url)")
                
                //把FB的個資存到firebase裡
                self.FBdata = ["email":email,"password":"xxxxxx","name":name,"avatar":url]
            }
        })
        
        //import Firebase後，連結Firebase與Facebook的Auth signin功能--(2)
        let accessToken = FBSDKAccessToken.current() //取得Token
        guard let accessTokenString = accessToken?.tokenString else { return } //解包
        //-----------------
        
        //-----------------
        
        let credntials = FIRFacebookAuthProvider.credential(withAccessToken: accessTokenString) //取得憑證
        FIRAuth.auth()?.signIn(with: credntials, completion: { (user, error) in
            if error != nil
            {
                print("FB連Firebase失敗", error ?? "")
                return
            }
            guard let uid = user?.uid else {
                return
            }
            print("成功用FB連進Firebase", uid)
            //把FB的個資存到firebase裡
            if let data = self.FBdata
            {
                FireBaseHandler.Instance.dbRef.child("Users").child(uid).updateChildValues(data)
            }
            SVProgressHUD.dismiss()
            self.performSegue(withIdentifier: "LoginSegue", sender: self)
        })
    }
    
    
    @IBAction func googleBtn(_ sender: UIButton)
    {
        //啟動google登入
        GIDSignIn.sharedInstance().signIn()
    }
    
    //MARK: - 簽完Google協定，要實作的方法
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!)
    {
        SVProgressHUD.show(withStatus: "登入中")
        if let err = error
        {
            print("使用Google登入失敗",err)
            SVProgressHUD.dismiss()
            return
        }
    
        //把Google導進firebase裡
        guard let idToken = user.authentication.idToken else { return }
        guard let accessToken = user.authentication.accessToken else { return }
        let credentials = FIRGoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        //-------------------
        //print("idToken = \(idToken)")
        //print("accessToken = \(accessToken)")
        //postUser(token: accessToken)
        //-------------------
        
        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
            
            if let err = error
            {
                print("用Google連Firebase登入失敗",err)
                SVProgressHUD.dismiss()
                return
            }
            guard let uid = user?.uid else { return }
            print("成功用Google連Firebase登入", uid)
            
            guard let photo = user?.photoURL else { return }
            let photoString = photo.absoluteString
            self.googledata = ["email":user?.email ?? "", "password":"xxxxxx", "name":user?.displayName ?? "", "avatar":photoString]
            //把Google的個資存到firebase裡
            if let data = self.googledata
            {
                FireBaseHandler.Instance.dbRef.child("Users").child(uid).updateChildValues(data)
            }
            SVProgressHUD.dismiss()
            self.performSegue(withIdentifier: "LoginSegue", sender: self)
        })
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
        print("Google帳號已登出")
    }
    
    
    
    //MARK: - checkLogin
    func checkLogin()
    {
        //如果現在真的有user的話就轉場
        if FIRAuth.auth()?.currentUser != nil
        {
            print("登入的CurrentUser = \(String(describing: FIRAuth.auth()?.currentUser))")
            self.performSegue(withIdentifier: "LoginSegue", sender: self)
        }
        else
        {
            print("現在沒使用者")
        }
    }
    
    
    //MARK: - 註冊鈕跳轉
    @IBAction func registerBtn(_ sender: UIButton)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signupVC = storyboard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        present(signupVC, animated: false, completion: nil)
    }
    
    
    
    //MARK: - 文字框按下return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - Alert Function
    func alertTheUser(title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }

    
    
    
    
    
    
    
    
    
    

    

}



















