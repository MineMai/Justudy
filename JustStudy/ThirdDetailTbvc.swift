//
//  ThirdDetailTbvc.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/24.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class ThirdDetailTbvc: UITableViewController {

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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdDetailHeroCell", for: indexPath) as! ThirdDetailHeroCell
                cell.detailImage.image = UIImage(named: "cat9")
                cell.detailKind.text = "英語"
                cell.detailPlace.text = "英國"
                cell.detailTopic.text = "多益證照"
                cell.detailSchool.text = "劍橋"
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdDetailCourseCell", for: indexPath) as! ThirdDetailCourseCell
                cell.detailCourse.text = "導演馬克偉柏 重回執導質感藝文片行列 細膩手法再現 ★美國隊長克里斯伊凡 放下盾牌卸下制服 獻出從影以來最真摯動人的演出 ★天才童星麥肯娜葛瑞絲首挑大樑 超強演技被譽為達科塔芬妮接班人 法蘭克艾德勒（克里斯伊凡 飾）獨自撫養著他的天才外甥女瑪莉"
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdDetailSchoolCell", for: indexPath) as! ThirdDetailSchoolCell
                cell.detailSchool.text = "導演馬克偉柏 重回執導質感藝文片行列 細膩手法再現 ★美國隊長克里斯伊凡 放下盾牌卸下制服 獻出從影以來最真摯動人的演出 ★天才童星麥肯娜葛瑞絲首挑大樑 超強演技被譽為達科塔芬妮接班人 法蘭克艾德勒（克里斯伊凡 飾）獨自撫養著他的天才外甥女瑪莉"
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
            vc.location = "Chome-1-2 Oshiage, Sumida, Tokyo 131-0045"
            //^//28-13 Sarugaku-Cho Shibuya-ku , Tokyo , 150-0033
            //^//350 5th Ave, New York, NY 10118
            //^//100 - 555 W 12th Avenue Vancouver, BC, Canada V5Z 3X7
            //^//Talamban RdCebu City, Cebu, Philippines
            //^//100 - 555 W 12th Avenue Vancouver, BC, Canada
            //Chome-1-2 Oshiage, Sumida, Tokyo 131-0045日本
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










