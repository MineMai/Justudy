//
//  MainVC.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/15.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import SVProgressHUD

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var firstContainerView: UIView!
    @IBOutlet weak var secondContainerView: UIView!
    @IBOutlet weak var thirdContainerView: UIView!
    @IBOutlet weak var fourthContainerView: UIView!
    
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var menuBarOutlet: UIBarButtonItem!
    
    @IBOutlet weak var menuCollection: UICollectionView!
    
    let menuIconNames = ["Menuhome", "Menutrending", "Menusubscriptions", "Menuaccount"]
    //menuBar需要的Constraint
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuCollection.delegate = self
        menuCollection.dataSource = self
        
        //指定menuBarButton的目標是側邊欄controller
        if revealViewController() != nil
        {
            menuBarOutlet.target = revealViewController()
            menuBarOutlet.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        }
        
        //ㄧ進來就先選第一個menuIcon
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        menuCollection.selectItem(at: selectedIndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition())
        
        //ㄧ進來就先選firstContainerView
        firstContainerView.isHidden = false
        secondContainerView.isHidden = true
        thirdContainerView.isHidden = true
        fourthContainerView.isHidden = true
        
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.title = "達人分享"
        setupHorizontalBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //檢查誰登入，並將資料取出，給側邊欄用
        isFBLogin = false
        isGoogleLogin = false
        checkWhoLogin()
        //loadProfile()
    }
    
    //MARK: - checkWhoLogin
    func checkWhoLogin()
    {
        let currentID = FIRAuth.auth()?.currentUser?.uid
        print("主頁currentUser = \(currentID ?? "") \n")
        
        if let user = FIRAuth.auth()?.currentUser
        {
            for profile in user.providerData //可以判斷是由哪個管道登入
            {
                print("profile = \(profile)")
                let providerId = profile.providerID
                print("userproviderId = \(providerId)")
                if providerId != "facebook.com" && providerId != "google.com"
                {
                    loadProfile()
                }
                else
                {
                    guard let name = profile.displayName else { return }
                    guard let email = profile.email else { return }
                    guard let photoUrl = profile.photoURL else { return }
                    if providerId == "facebook.com"
                    {
                        print("進入FB")
                        isFBLogin = true
                        fbUsers = FBUsers(name: name, email: email, pictureURL: photoUrl)
                    }
                    else
                    {
                        print("進入Google")
                        isGoogleLogin = true
                        googleUsers = Googlesers(name: name, email: email, pictureURL: photoUrl)
                    }
                }
                //let uid = profile.uid // Provider-specific UID
                //print("userUID = \(uid)")
                //print("userName = \(String(describing: name))")
                //print("useremail = \(String(describing: email))")
                //print("userphotoUrl = \(String(describing: photoUrl))")
            }
        }
        else {
            print("無使用者登入")
        }
    }
    
    
    //MARK: - loadProfile給側邊欄用的
    func loadProfile()
    {
        SVProgressHUD.show(withStatus: "載入中")
        let currentID = FIRAuth.auth()?.currentUser?.uid
        FireBaseHandler.Instance.dbRef.child("Users").child(currentID!).observeSingleEvent(of: .value) { (snapshot:FIRDataSnapshot) in
            
            let snap = snapshot.value as! [String:String]
            var userName = snap["name"]
            var userImageURL = snap["avatar"]
            print("userImageURL = \(String(describing: userImageURL))")
            if userImageURL == nil
            {
                userImageURL = "https://firebasestorage.googleapis.com/v0/b/juststudy-fd5a5.appspot.com/o/profile_picture.png?alt=media&token=d1fdbb27-fe4c-467b-b941-c321735f233c"
            }
            if userName == nil
            {
                userName = "未命名"
            }
            sideProfileName = userName
            
            let storage = FIRStorage.storage()
            let imageURL = storage.reference(forURL: userImageURL!)
                
            imageURL.downloadURL(completion: { (url, error) in
                    
                if error != nil {
                    print("downloadURL Error:\(String(describing: error?.localizedDescription))")
                    return
                }
                URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                        
                    if error != nil {
                        print(error ?? "")
                        return
                    }
                    guard let imageData = UIImage(data: data!) else { return }
                    sideProfileImage = imageData
                        
                    SVProgressHUD.dismiss()
                }).resume()
            })
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let menucell = menuCollection.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCollectionCell
        menucell.menuIcon.image = UIImage(named: menuIconNames[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        menucell.tintColor = UIColor(red: 0.356, green: 0.054, blue: 0.05, alpha: 1.0)
        menucell.backgroundColor = UIColor.red
        return menucell
        
    }
    
    
    //CollectionView 內建就有scrollView的這方法
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
        horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    
    //MARK: - collectionView Layout
    //有簽協定UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 4, height: view.frame.height)
    }
    
    
    //MARK: - 設定menuBar小白線
    func setupHorizontalBar() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        menuView.addSubview(horizontalBarView)
        
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: menuView.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        
        horizontalBarView.bottomAnchor.constraint(equalTo: menuView.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: menuView.widthAnchor, multiplier: 1/4).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let x = CGFloat(indexPath.item) * menuView.frame.width / 4
        horizontalBarLeftAnchorConstraint?.constant = x
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping:1, initialSpringVelocity: 1, options: .curveEaseOut, animations:{
                self.menuView.layoutIfNeeded()
            }, completion: nil)
        
        let page = indexPath.item
        //決定要顯示哪一頁
        switch page
        {
            case 0:
                firstContainerView.isHidden = false
                secondContainerView.isHidden = true
                thirdContainerView.isHidden = true
                fourthContainerView.isHidden = true
                navigationItem.title = "達人分享"
            case 1:
                firstContainerView.isHidden = true
                secondContainerView.isHidden = false
                thirdContainerView.isHidden = true
                fourthContainerView.isHidden = true
                navigationItem.title = "留學說明會"
            case 2:
                firstContainerView.isHidden = true
                secondContainerView.isHidden = true
                thirdContainerView.isHidden = false
                fourthContainerView.isHidden = true
                navigationItem.title = "學校面對面"
            case 3:
                firstContainerView.isHidden = true
                secondContainerView.isHidden = true
                thirdContainerView.isHidden = true
                fourthContainerView.isHidden = false
                navigationItem.title = "英語證照"
            default:
                break
        }
        
    }
    

    

}





