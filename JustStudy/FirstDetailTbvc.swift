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
            cell.heroImage.image = UIImage(named: "demo-6")
            heroCell = cell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! FirstInfoCell
            cell.firstInfoTopic.text = "123"
            cell.firstInfoTime.text = "456"
            cell.firstInfoPlaceBtn.setTitle("10650台北市大安區信義路2段166號", for: .normal)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as! FirstDescriptionCell
            cell.firstDescription.text = "國際品牌顧問公司BrandKeys公佈2016全球百大忠誠品牌在前十名中，Apple的平板和手機各佔據兩個名次Amazon的三項服務各佔據三個名次"
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "teacherCell", for: indexPath) as! FirstTeacherCell
            cell.firstTeacherLabel.text = "亞洲倍數模式實踐發揚者，豐富跨領域產業背景資深企業管理顧問輔導企業超過50間"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "organizerCell", for: indexPath) as! FirstOrganizerCell
            cell.firstOrganizerLabel.text = "工業研究院"
            return cell
        }
        
    }
    
    
    //MARK: preparForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goMapSegue"
        {
            let mapvc = segue.destination as? FirstMapVC
            mapvc?.targetLocation = "10650台北市大安區信義路2段166號"
            
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
