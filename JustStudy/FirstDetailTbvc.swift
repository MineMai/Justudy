//
//  FirstDetailTbvc.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/22.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class FirstDetailTbvc: UITableViewController {
    
    
    var heroCell:firstHeroCell? //因為要把heroCell給scroll用
    var detailIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        //把navigationBar變透明
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //把TableView往上移
        tableView.contentInset = UIEdgeInsets(top: -64, left: 0, bottom: 0, right: 0)*/
        
        
    }

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section
        {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "heroCell", for: indexPath) as! firstHeroCell
            let cacheURL = URL(string: activity[detailIndex].image1!)
            cell.heroImage.sd_setImage(with: cacheURL, placeholderImage: UIImage(named: "picture_placeholder.png"))
            
            heroCell = cell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! FirstInfoCell
            cell.firstInfoTopic.text = activity[detailIndex].subject
            cell.firstInfoTime.text = activity[detailIndex].date
            cell.firstInfoPlaceBtn.setTitle(activity[detailIndex].location, for: .normal)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as! FirstDescriptionCell
            cell.firstDescription.text = activity[detailIndex].description
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "teacherCell", for: indexPath) as! FirstTeacherCell
            cell.firstTeacherLabel.text = activity[detailIndex].presenter_info
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "organizerCell", for: indexPath) as! FirstOrganizerCell
            cell.firstOrganizerLabel.text = activity[detailIndex].organizer
            return cell
        }
        
    }
    
    
    //MARK: preparForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goMapSegue"
        {
            let mapvc = segue.destination as? FirstMapVC
            mapvc?.targetLocation = activity[detailIndex].location
            
//            if let index = detailindex
//            {
//                mapvc?.mapIndex = index
//            }
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        /*
        switch indexPath.section {
        case 0:
            return UITableViewAutomaticDimension
        case 1:
            return UITableViewAutomaticDimension
        case 2:
            return UITableViewAutomaticDimension
        case 3:
            return UITableViewAutomaticDimension
        default:
            return 150
        } */
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //MARK: - 偵測scroll
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if let cell = heroCell
        {
            if scrollView.contentOffset.y < 0
            {
                cell.heroImageTopConstraint.constant = scrollView.contentOffset.y
            }
            
        }
    }
    
    
    

    

}
