//
//  VidioVC.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/27.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import youtube_ios_player_helper


class VidioVC: UIViewController,YTPlayerViewDelegate {
    
    var getVideoAddress:String?
    
    @IBOutlet weak var yView: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.yView.delegate = self
        yView.load(withVideoId: "\(getVideoAddress!)", playerVars: ["playsinline":0,"rel":0,"showinfo":0])
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        self.yView.playVideo()
    }
}













