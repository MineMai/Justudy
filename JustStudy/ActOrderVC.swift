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
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookedAct.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActOrderCell", for: indexPath) as! ActOrderCell
        
        //cell.imageView.image = nil
        cell.actOrderTitle.text = bookedAct[indexPath.row].subject
        cell.buttonLabel.text = bookedAct[indexPath.row].date
        cell.actOrderSubtitle.text = bookedAct[indexPath.row].schoolName
        cell.imageView.image = UIImage(named: bookedAct[indexPath.row].image!)
        
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

















