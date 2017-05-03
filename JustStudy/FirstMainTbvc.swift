//
//  FirstMainTbvc.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/20.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import SVProgressHUD

class FirstMainTbvc: UITableViewController {
    
    lazy var session = { return URLSession(configuration: .default) }()
    
    var isLikeSelected = Array(repeating: false, count: testdata.posts.count)
    
    let pullToRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        //加入下拉更新
        tableView.refreshControl = pullToRefreshControl
        pullToRefreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        
        loadData()
    
    }
    
    // MARK: - 下拉更新
    func refreshTable()
    {
        loadData()
        tableView.reloadData()
        pullToRefreshControl.endRefreshing()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - loadData
    func loadData()
    {
        SVProgressHUD.show(withStatus: "Loading")
        let apiAddress = "http://api.justudy.tw/v1/activities"
        
        if let url = URL(string: apiAddress)
        {
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if error != nil
                {
                    print(error?.localizedDescription as Any)
                }
                if let downloadedData = data
                {
                    do
                    {
                        let json = try JSONSerialization.jsonObject(with: downloadedData, options: [])
                        
                        DispatchQueue.main.async {
                            self.parseJSON(json: json)
                        }
                    }
                    catch{
                        
                    }
                }
            })
            task.resume() //開始執行下載
        }
    }
    
    func parseJSON(json:Any)
    {
        activity = []
        if let okJSON = json as? [String:Any]
        {
            if let json = okJSON["result"] as? [[String:Any]]
            {
                for i in 0..<json.count
                {
                    let data = json[i]
                    guard let id = data["id"] as? Int, let subject = data["subject"] as? String, let description = data["description"] as? String, let datetime = data["datetime"] as? String, let location = data["location"] as? String, let presenter_name = data["presenter_name"] as? String, let presenter_info = data["presenter_info"] as? String, let organizer = data["organizer"] as? String, let liked = data["liked"] as? Int, let image1 = data["card_image"] as? [String:String], let image2  = data["banner_image"] as? [String:String] else {return}
                    
                    let myDate = datetime
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    let date = dateFormatter.date(from:myDate)!
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                    let dateString = dateFormatter.string(from:date)
                    
                    guard let url1 = image1["url"] else {return}
                    
                    guard let url2 = image2["url"] else {return}
                    
                    let act = Activity(id: id, subject: subject, description: description, date: dateString, location: location, presenter_name: presenter_name, presenter_info: presenter_info, organizer: organizer, liked: liked, image1: url1, image2: url2)
                    activity.append(act)
                    tableView.reloadData()
                    SVProgressHUD.dismiss()
                }
            }
        }
    }
    
    
    
    
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activity.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstMainTbvCell", for: indexPath) as! FirstMainTbvCell
        
        cell.firstLikeBtn.isSelected = isLikeSelected[indexPath.row]
        cell.firstTopicLabel.text = activity[indexPath.row].subject
        cell.firstTimeLabel.text = activity[indexPath.row].date
        cell.firstPlaceLabel.text = activity[indexPath.row].location
        //cell.firstImageView.image = UIImage(named: testdata.posts[indexPath.row]["image"]!)
        
        let cacheURL = URL(string: activity[indexPath.row].image1!)
        cell.firstImageView.sd_setImage(with: cacheURL, placeholderImage: UIImage(named: "picture_placeholder.png"))
        
        cell.firstLikeBtn.tag = indexPath.row
        cell.firstLikeBtn.addTarget(self, action: #selector(likePressed), for: .touchUpInside)

        return cell
    }
    
    
    //MARK: - didSelectRowAt
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tabBarController?.tabBar.isHidden = true
        let _ = performSegue(withIdentifier: "firstShowSegue", sender: nil)
        
        //消除點選的灰色
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "firstShowSegue"
        {
            let vc = segue.destination as! FirstVC
            vc.firstVCIndex = (tableView.indexPathForSelectedRow?.row)!
        }
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
            likedActivity.append(activity[buttonRow]) //點了收藏存進Array
        }
        
    }
    

    

}












