//
//  MemberListTVC.swift
//  JustStudy
//
//  Created by Ember on 2017/4/26.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import Firebase //***

class MemberListTVC: UITableViewController {
    
    let ref = FIRDatabase.database().reference()
    var roomArray: [FIRDataSnapshot] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        ref.child("managerList").observe(.value, with: { (snapShots) in //觀察這個key值的變化
            self.roomArray.removeAll()
            for snapShot in snapShots.children {
                self.roomArray.append(snapShot as! FIRDataSnapshot)
            }
            self.tableView.reloadData()
        })
    }

    //對話名單列表呈現
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return roomArray.count
    }
    
    //.value -> email address
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        let email = roomArray[indexPath.row].value
        cell.textLabel?.text = email as? String
        
        //resize the dot
        cell.imageView?.image = UIImage(named: "newDot")
        let itemSize = CGSize(width:10.0, height:10.0)
        UIGraphicsBeginImageContextWithOptions(itemSize, false, 0.0)
        let imageRect = CGRect(x:0.0, y:0.0, width:itemSize.width, height:itemSize.height)
        cell.imageView?.image!.draw(in:imageRect)
        cell.imageView?.image! = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.imageView?.image = nil
    }
    
    //轉場時將key帶至下個畫面處理，其為uid，下頁用uid帶出對話內容
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let dvc = segue.destination as! ManagerVC
        //抓到點的欄位的key值
        dvc.key = roomArray[tableView.indexPathForSelectedRow!.row].key
    }
    
    //移除對話列表動作
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editButton = UITableViewRowAction(style: .destructive, title: "Delete") { (actin, indexPath) in
            let key = self.roomArray[indexPath.row].key
            self.ref.child("managerList/\(key)").removeValue(completionBlock: { (error, ref) in
                
            })
        }
        return [editButton]
    }

}
