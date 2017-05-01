//
//  IntroPageVC.swift
//  JustStudy
//
//  Created by Ember on 2017/4/26.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import CHIPageControl

class IntroPageVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var introPageControl: CHIBasePageControl!
    @IBOutlet weak var introHeadLabel: UILabel!
    @IBOutlet weak var introMessageLabel: UILabel!
    @IBOutlet weak var introCollectionView: UICollectionView!
    @IBOutlet weak var introNextButton: UIButton!
    @IBOutlet weak var introStartButton: UIButton!
    @IBOutlet weak var introSkipButton: UIButton!
    
    var progress = 0.0
    var pageIndexPath:IndexPath?
    let introPageNumbers = 4
    var introPageData:[IntroPage] = [
        IntroPage(head: "Justudy", message: "畢業即失業？\n厭倦一成不變的生活？\n找不到人生方向？\n想投資或是改變自己？", image: "intro0"),
        IntroPage(head: "Justudy", message: "提供國外學校中文線上服務\n直接、無隔閡、無國界\n可面對面諮詢＆活動預約", image: "intro1"),
        IntroPage(head: "Justudy", message: "邀請國外海歸或業界達人\n分享相關趨勢與經驗\n解答您的不安與疑惑", image: "intro2"),
        IntroPage(head: "Justudy", message: "精準選擇未來所需\n提升語言聽說讀寫能力\n取得專業技能國際證照", image: "intro3")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init labels
        //introHeadLabel.text = introPageData[0].head
        introMessageLabel.text = introPageData[0].message
        
        //init page number
        self.introPageControl.numberOfPages = self.introPageNumbers
    }
    
    
    //status bar style
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    //collectionview implement
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
        //return introPageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "introCell", for: indexPath) as! IntroPageCVC
        cell.introBackgroundImage.image = UIImage(named: "intro\(indexPath.row)")
        
        //cell.introBackgroundImage.image = UIImage(named: introPageData[indexPath.row].image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return self.view.bounds.size
        
    }
    
    //behavior of scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let total = scrollView.contentSize.width - scrollView.bounds.width
        let offset = scrollView.contentOffset.x
        let percent = Double(offset / total)
        
        progress = percent * Double(self.introPageNumbers - 1)
        self.introPageControl.progress = progress
        
        if progress != 3{
            introNextButton.isHidden = false
            introSkipButton.isHidden = false
            introStartButton.isHidden = true
            //introHeadLabel.text = introPageData[Int(progress)].head
            introMessageLabel.text = introPageData[Int(progress)].message
        }else{
            introNextButton.isHidden = true
            introSkipButton.isHidden = true
            introStartButton.isHidden = false
            //introHeadLabel.text = introPageData[3].head
            introMessageLabel.text = introPageData[3].message
        }
    }


    @IBAction func introNextButton(_ sender: UIButton) {
        let pageIndexPath = IndexPath(row: Int(progress) + 1, section: 0)
        if pageIndexPath.row != 4{
            introCollectionView.scrollToItem(at: pageIndexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        
        }
    }
    
    @IBAction func introStartButton(_ sender: UIButton) {
               
        //畫面切換
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    @IBAction func introSkipButton(_ sender: UIButton) {
        let pageIndexPath = IndexPath(row: 3, section: 0)
        introCollectionView.scrollToItem(at: pageIndexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
    }
    
}
