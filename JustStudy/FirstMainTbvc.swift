//
//  FirstMainTbvc.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/20.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class FirstMainTbvc: UITableViewController {
    
    var isLikeSelected = Array(repeating: false, count: testdata.posts.count)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return testdata.posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstMainTbvCell", for: indexPath) as! FirstMainTbvCell
        
        cell.firstLikeBtn.isSelected = isLikeSelected[indexPath.row]
        cell.firstTopicLabel.text = testdata.posts[indexPath.row]["topic"]
        cell.firstTimeLabel.text = testdata.posts[indexPath.row]["time"]
        cell.firstPlaceLabel.text = testdata.posts[indexPath.row]["place"]
        cell.firstImageView.image = UIImage(named: testdata.posts[indexPath.row]["image"]!)
        
        cell.firstLikeBtn.tag = indexPath.row
        cell.firstLikeBtn.addTarget(self, action: #selector(likePressed), for: .touchUpInside)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tabBarController?.tabBar.isHidden = true
        let _ = performSegue(withIdentifier: "firstShowSegue", sender: nil)
        
    }
    
    func likePressed(sender:DOFavoriteButton)
    {
        let buttonRow = sender.tag
        
        if sender.isSelected {
            sender.deselect()
            isLikeSelected.remove(at: buttonRow)
            isLikeSelected.insert(false, at: buttonRow)
        } else {
            sender.select()
            isLikeSelected.remove(at: buttonRow)
            isLikeSelected.insert(true, at: buttonRow)
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
