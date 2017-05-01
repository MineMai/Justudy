//
//  ActOrderVC.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/24.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import FirebaseAuth

class ActOrderVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActOrderCell", for: indexPath) as! ActOrderCell
        
        //cell.imageView.image = nil
        cell.actOrderTitle.text = testdata.posts[indexPath.row]["topic"]
        cell.actOrderSubtitle.text = testdata.posts[indexPath.row]["time"]
        cell.imageView.image = UIImage(named: testdata.posts[indexPath.row]["image"]!)
        
        //let cacheURL = URL(string: hostMsg[indexPath.row].imageURL)
        
        //cell.imageView.sd_setImage(with: cacheURL, placeholderImage: UIImage(named: "picture_placeholder.png"))
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showQRSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQRSegue"{
            let dvc = segue.destination as! ShowQRcodeVC
            dvc.activityName = testdata.posts[(collectionView.indexPathsForSelectedItems?.first?.row)!]["topic"]!
        }
    }

   
}

















