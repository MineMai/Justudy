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
        
        let userInfo = getMember[indexPath.row].components(separatedBy: ",")
        
        cell.textLabel?.text = "\(userInfo[1])"
        cell.detailTextLabel?.text = getTime[indexPath.row]
        cell.detailTextLabel?.textColor = UIColor.lightGray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let scriptUrl = "https://script.google.com/macros/s/AKfycbyadkr-rxTMjtxtB0WB_cGJRiZqrNvByuZ05o75QNXUUIJKw_c/exec"
            
            // QueryString與app 串資料
            let urlWithParams = scriptUrl + "?rownumber=\(indexPath.row + 1)&type=get"
            
            let url = URL(string: urlWithParams.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!
            
            print(url)
            var urlRequest = URLRequest(url:url)
            urlRequest.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) {
                data, response, error in
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("responseString = \(responseString!)")
                
                // Check for error
                if error != nil {
                    print("error=\(error!)")
                } else {
                    print("pass")
                }
            }
            task.resume()
            
            getMember.remove(at: indexPath.row)
            getTime.remove(at: indexPath.row)
            
            print(getMember)
            
            listTableView.reloadData()
        }
    }
    
    @IBAction func clearBarButton(_ sender: UIBarButtonItem) {
        let clearAlert = UIAlertController(title: "清除名單", message: "確定是否清除報到名單?", preferredStyle: .alert)
        clearAlert.addAction(UIAlertAction(title: "確定", style: .default, handler: { (UIAlertAction) in
            
            self.getMember.removeAll()
            self.getTime.removeAll()
            self.listTableView.reloadData()
            
            let scriptUrl = "https://script.google.com/macros/s/AKfycbxFKxTPHiNS5Hh9KI2aEt3lA_mKVvG86ZY7AFeB1foPYc_alRU/exec"
            
            // QueryString與app 串資料
            let urlWithParams = scriptUrl + "?type=get"
            
            let url = URL(string: urlWithParams.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!
            
            print(url)
            var urlRequest = URLRequest(url:url)
            urlRequest.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) {
                data, response, error in
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("responseString = \(responseString!)")
                
                // Check for error
                if error != nil {
                    print("error=\(error!)")
                } else {
                    print("pass")
                }
            }
            task.resume()
        }))
        
        clearAlert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.present(clearAlert, animated: true, completion: nil)
  
    }
    
    
}
