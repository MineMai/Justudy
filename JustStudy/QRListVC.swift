//
//  QRListVC.swift
//  JustStudy
//
//  Created by Ember on 2017/4/28.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class QRListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var listTableView: UITableView!
    
    var getMember = [String]()
    var getTime = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        let notificationName = Notification.Name("sendBackArray")
        NotificationCenter.default.post(name: notificationName,
                                        object: nil,
                                        userInfo: ["member": getMember, "time": getTime])
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getMember.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let userInfo = getMember[getMember.count - indexPath.row - 1].components(separatedBy: ",")
        
        cell.textLabel?.text = "\(userInfo[1])"
        cell.detailTextLabel?.text = getTime[getTime.count - indexPath.row - 1]
        cell.detailTextLabel?.textColor = UIColor.lightGray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
                     
            getMember.remove(at: getMember.count - indexPath.row - 1)
            getTime.remove(at: getTime.count - indexPath.row - 1)
            
            listTableView.reloadData()
        }
    }
    
    @IBAction func clearBarButton(_ sender: UIBarButtonItem) {
        let clearAlert = UIAlertController(title: "清除名單", message: "確定是否清除報到名單?", preferredStyle: .alert)
        clearAlert.addAction(UIAlertAction(title: "確定", style: .default, handler: { (UIAlertAction) in
            
            self.getMember.removeAll()
            self.getTime.removeAll()
            self.listTableView.reloadData()
            
        }))
        
        clearAlert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.present(clearAlert, animated: true, completion: nil)
  
    }
    
    
}
