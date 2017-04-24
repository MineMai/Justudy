//
//  ActLikeVC.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/24.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class ActLikeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testdata.posts.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActLikeCell", for: indexPath) as! ActLikeCell
        
        //cell.imageView.image = nil
        cell.actLikeTitle.text = testdata.posts[indexPath.row]["topic"]
        cell.actLikeSubtitle.text = testdata.posts[indexPath.row]["time"]
        cell.imageView.image = UIImage(named: testdata.posts[indexPath.row]["image"]!)
        
        //let cacheURL = URL(string: hostMsg[indexPath.row].imageURL)
        
        //cell.imageView.sd_setImage(with: cacheURL, placeholderImage: UIImage(named: "picture_placeholder.png"))
        
        return cell
        
    }
    
    
    
    

    

}








