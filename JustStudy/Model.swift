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
var googleUsers:GooglUsers?

class GooglUsers
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


var activity = [Activity]()

class Activity
{
    var id:Int?
    var subject:String?
    var description:String?
    var date:String?
    var location:String?
    var presenter_name:String?
    var presenter_info:String?
    var organizer:String?
    var liked:Int?
    var image1:String?
    var image2:String?
    
    init(id:Int, subject:String, description:String, date:String, location:String, presenter_name:String, presenter_info:String, organizer:String, liked:Int, image1:String, image2:String)
    {
        self.id = id
        self.subject = subject
        self.description = description
        self.date = date
        self.location = location
        self.presenter_name = presenter_name
        self.presenter_info = presenter_info
        self.organizer = organizer
        self.liked = liked
        self.image1 = image1
        self.image2 = image2
    }
}


















