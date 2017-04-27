//
//  FourthVC.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/20.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class FourthVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        backgroundImage.image = UIImage(named: testdata.posts[0]["image"]!)
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FourthCollectionCell", for: indexPath) as! FourthCollectionCell
        
        cell.heroImage.image = UIImage(named: testdata.posts[indexPath.row]["image"]!)
//        cell.heroBackImage.image = UIImage(named: testdata.posts[indexPath.row]["image"]!)
        
        return cell
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(floor((scrollView.contentOffset.x - 150) / 300 ) + 1)
        backgroundImage.image = UIImage(named: testdata.posts[pageIndex]["image"]!)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showVidioSegue", sender: nil)
    }
    
    
    
    
    
    
    

}





















