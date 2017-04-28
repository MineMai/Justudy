//
//  VidioVC.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/27.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import youtube_ios_player_helper


class VidioVC: UIViewController {
    
    
    @IBOutlet weak var yView: YTPlayerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        yView.load(withVideoId: "KhrOA0HnnLk", playerVars: ["playsinline":1,"rel":0,"showinfo":0])
        
        
    }
    
    
    

    

}













