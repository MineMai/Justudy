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
//    var introPageData:[IntroPage] = [IntroPage(head: "H1", message: "M1", image: "intro1"),
//                                     IntroPage(head: "H2", message: "M2", image: "intro2"),
//                                     IntroPage(head: "H3", message: "M3", image: "intro3"),
//                                     IntroPage(head: "H4", message: "M4", image: "intro4")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init labels
        //introHeadLabel.text = introPageData[0].head
        //introMessageLabel.text = introPageData[0].message
        
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
            //introMessageLabel.text = introPageData[Int(progress)].message
        }else{
            introNextButton.isHidden = true
            introSkipButton.isHidden = true
            introStartButton.isHidden = false
            //introHeadLabel.text = introPageData[3].head
            //introMessageLabel.text = introPageData[3].message
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
