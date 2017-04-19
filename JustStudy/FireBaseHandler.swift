//
//  FireBaseHandler.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/16.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import Foundation
import Firebase

struct LoginErrorCode
{
    static let INVALID_EMAIL = "無效的Email"
    static let WRONG_PASSWORD = "密碼錯誤"
    static let PROBLEM_CONNECTING = "連結資料庫有問題，請稍候再試"
    static let USER_NOT_FOUND = "找不到使用者，請先註冊"
    static let EMAIL_ALREADY_IN_USE = "此Email已使用"
    static let WEAK_PASSWORD = "密碼必須6碼以上"
}


class FireBaseHandler
{
    private static let _instance = FireBaseHandler()
    static var Instance:FireBaseHandler {
        return _instance
    }
    
    var dbRef:FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    var storageRef:FIRStorageReference {
        return FIRStorage.storage().reference()
    }
    
    
    func logIn(email:String, password:String, loginHandler:@escaping (_ msg:String?)->())
    {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil
            {
                //登入失敗
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler)
            }
            else
            {   //登入成功
                loginHandler(nil)
            }
        })
    }// logIn
    
    func signUp(email:String, password:String, name:String, avatarURL:String, loginHandler:@escaping (_ msg:String?)->())
    {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil
            {
                //創建失敗
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler)
            }
            else
            {
                //創建成功
                if user?.uid != nil
                {
                    //就將此user存進database
                    let data:[String:Any] = ["email":email, "password":password, "name":name, "avatar":avatarURL]
                    self.dbRef.child("Users").child((user?.uid)!).setValue(data)
                    
                    //然後就登入進去
                    self.logIn(email: email, password: password, loginHandler: loginHandler)
                }
            }
        })
    }// signUp
    
    func logOut() -> Bool
    {
        if FIRAuth.auth()?.currentUser != nil
        {
            do
            {
                try FIRAuth.auth()?.signOut()
                return true
            }
            catch
            {
                return false
            }
        }
        return true
    }// logout
    
    
    private func handleErrors(err:NSError, loginHandler:(_ msg:String?)->())
    {
        if let errCode = FIRAuthErrorCode(rawValue: err.code)
        {
            switch errCode
            {
            case .errorCodeWrongPassword:
                loginHandler(LoginErrorCode.WRONG_PASSWORD)
            case .errorCodeInvalidEmail:
                loginHandler(LoginErrorCode.INVALID_EMAIL)
            case .errorCodeUserNotFound:
                loginHandler(LoginErrorCode.USER_NOT_FOUND)
            case .errorCodeEmailAlreadyInUse:
                loginHandler(LoginErrorCode.EMAIL_ALREADY_IN_USE)
            case .errorCodeWeakPassword:
                loginHandler(LoginErrorCode.WEAK_PASSWORD)
            default:
                loginHandler(LoginErrorCode.PROBLEM_CONNECTING)
            }
        }
    }// handleErrors
    
    
    
    
    
}
























