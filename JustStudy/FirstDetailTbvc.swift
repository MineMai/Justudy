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
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "heroCell", for: indexPath) as! firstHeroCell
            cell.heroImage.image = UIImage(named: "demo-6")
            heroCell = cell
            return cell
        }
        else
        {
            let cell = UITableViewCell()
            
            return cell
        }
    
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return UITableViewAutomaticDimension
        case 1:
            return 150
        case 2:
            return 150
        default:
            return 150
        }
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
