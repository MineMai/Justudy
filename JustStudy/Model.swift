//
//  Model.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/16.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import Foundation

var isFBLogin = false
var fbUsers:FBUsers?

class FBUsers
{
    var name:String?
    var email:String?
    var pictureURL:URL?
    
    init(name:String, email:String, pictureURL:URL)
    {
        self.name = name
        self.email = email
        self.pictureURL = pictureURL
    }
}

var isGoogleLogin = false
var googleUsers:Googlesers?

class Googlesers
{
    var name:String?
    var email:String?
    var pictureURL:URL?
    
    init(name:String, email:String, pictureURL:URL)
    {
        self.name = name
        self.email = email
        self.pictureURL = pictureURL
    }
}

//如果用Firebase登入就要把照片名字先存起來，給側邊欄用
var sideProfileImage:UIImage?
var sideProfileName:String?


//IntroPages' model
class IntroPage{
    
    var head = ""
    var message = ""
    var image = ""
    
    init(head:String,message:String,image:String) {
        self.head = head
        self.message = message
        self.image = image
    }
}








