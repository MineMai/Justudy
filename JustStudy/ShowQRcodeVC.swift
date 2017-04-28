//
//  ShowQRcodeVC.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/27.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import FirebaseAuth

class ShowQRcodeVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topicLabel: UILabel!
    
    var qrcodeImage:CIImage!
    var activityName:String!
    var userMail:String! = FIRAuth.auth()?.currentUser?.email
    var justudy = "@justudy#"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topicLabel.text = activityName
        let dataSet = "\(justudy),\(userMail)"
        if qrcodeImage == nil {
            
            let data = dataSet.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
            let filter = CIFilter(name: "CIQRCodeGenerator")
            filter?.setValue(data, forKey: "inputMessage")
            filter?.setValue("Q", forKey: "inputCorrectionLevel")
            qrcodeImage = filter?.outputImage
            displayQRCodeImage()
        }else{
            imageView.image = nil
            qrcodeImage = nil
        }
    }
    
    func displayQRCodeImage(){
        
        let scaleX = imageView.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = imageView.frame.size.height / qrcodeImage.extent.size.height
        let transformedImage = qrcodeImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
        imageView.image = UIImage(ciImage: transformedImage)
    }
    
    
    
    

    

}



















