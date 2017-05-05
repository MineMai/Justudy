//
//  ThirdDetailTbvc.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/24.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class ThirdDetailTbvc: UITableViewController {
    
    var detailTbvcKind = 0
    var detailTbvcIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }

    //licenseData.posts[listIndex][indexPath.row]["subject"]
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdDetailHeroCell", for: indexPath) as! ThirdDetailHeroCell
                cell.detailImage.image = UIImage(named: (licenseData.posts[detailTbvcKind][detailTbvcIndex]["image"] as! String))
                cell.detailKind.text = (licenseData.posts[detailTbvcKind][detailTbvcIndex]["type"] as! String)
                cell.detailPlace.text = (licenseData.posts[detailTbvcKind][detailTbvcIndex]["address"] as! String)
                cell.detailTopic.text = (licenseData.posts[detailTbvcKind][detailTbvcIndex]["subject"] as! String)
                cell.detailSchool.text = (licenseData.posts[detailTbvcKind][detailTbvcIndex]["school_name"] as! String)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdDetailCourseCell", for: indexPath) as! ThirdDetailCourseCell
                cell.detailCourse.text = (licenseData.posts[detailTbvcKind][detailTbvcIndex]["course_detail"] as! String)
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdDetailSchoolCell", for: indexPath) as! ThirdDetailSchoolCell
                cell.detailSchool.text = (licenseData.posts[detailTbvcKind][detailTbvcIndex]["school_detail"] as! String)
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdDetailTourCell", for: indexPath) as! ThirdDetailTourCell
                return cell
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ThirdMapSegue"
        {
            let vc = segue.destination as! ThirdMapVC
            //vc.location = "Chome-1-2 Oshiage, Sumida, Tokyo 131-0045"
            vc.mapViewKind = detailTbvcKind
            vc.mapViewIndex = detailTbvcIndex
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0
        {
            return 320
        }
        else
        {
            return UITableViewAutomaticDimension
        }
    
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
    
    
    
    

    

}










