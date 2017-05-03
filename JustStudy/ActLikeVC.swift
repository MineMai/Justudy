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
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likedActivity.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActLikeCell", for: indexPath) as! ActLikeCell
        
        //cell.imageView.image = nil
        cell.actLikeTitle.text = likedActivity[indexPath.row].subject
        cell.actLikeSubtitle.text = likedActivity[indexPath.row].date
        //cell.imageView.image = UIImage(named: likedActivity[indexPath.row].image1!)
        
        let cacheURL = URL(string: likedActivity[indexPath.row].image1!)
        
        cell.imageView.sd_setImage(with: cacheURL, placeholderImage: UIImage(named: "picture_placeholder.png"))
        
        return cell
        
    }
    
    
    
    

    

}








