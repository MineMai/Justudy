//
//  ThirdLiseVC.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/23.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class ThirdLiseVC: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var isLikeSelected = Array(repeating: false, count: testdata.posts.count)
    
    var myScrollView: UIScrollView!
    var pageControl: UIPageControl!
    // 取得螢幕的尺寸
    var fullSize :CGSize! = UIScreen.main.bounds.size

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setScrollImage()
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return testdata.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdLiseCell", for: indexPath) as! ThirdLiseCell
        
        cell.lisenceLikeBtn.isSelected = isLikeSelected[indexPath.row]
        cell.lisenceTopic.text = "哈利波特魔法"
        cell.lisencePlace.text = "英國"
        cell.lisenceKind.text = "魔術"
        cell.lisenceImage.image = UIImage(named: "demo-6")
        cell.lisenceLikeBtn.tag = indexPath.row
        cell.lisenceLikeBtn.addTarget(self, action: #selector(likePressed),for: .touchUpInside)
            
        return cell
        
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
    
    
    
    
    
    
    
    
    func setScrollImage()
    {
        // 建立 UIScrollView
        myScrollView = UIScrollView()
        // 設置尺寸 也就是可見視圖範圍
        myScrollView.frame = CGRect(x: 0, y: 0, width: topView.frame.width, height: topView.frame.height)
        // 實際視圖範圍
        myScrollView.contentSize = CGSize(width: topView.frame.width * 5, height: topView.frame.height)
        
        // 是否顯示滑動條
        myScrollView.showsHorizontalScrollIndicator = false
        myScrollView.showsVerticalScrollIndicator = false
        // 滑動超過範圍時是否使用彈回效果
        myScrollView.bounces = true
        // 設置委任對象
        myScrollView.delegate = self
        // 以一頁為單位滑動
        myScrollView.isPagingEnabled = true
        // 加入到畫面中
        myScrollView.backgroundColor = UIColor.yellow
        self.topView.addSubview(myScrollView)
        
        
        // 建立 UIPageControl 設置位置及尺寸
        pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: fullSize.width * 0.85, height: 30))
        pageControl.center = CGPoint(x: fullSize.width * 0.5, y: topView.frame.height * 0.9)
        // 有幾頁 就是有幾個點點
        pageControl.numberOfPages = 5
        // 起始預設的頁數
        pageControl.currentPage = 0
        // 目前所在頁數的點點顏色
        pageControl.currentPageIndicatorTintColor = UIColor.white
        // 其餘頁數的點點顏色
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        // 增加一個值改變時的事件
        pageControl.addTarget(self, action: #selector(pageChanged(_:)), for: .valueChanged)
        // 加入到基底的視圖中 (不是加到 UIScrollView 裡)
        // 因為比較後面加入 所以會蓋在 UIScrollView 上面
        pageControl.backgroundColor = UIColor.clear
        self.topView.addSubview(pageControl)
        
        for i in 0...4
        {
            let myImageView = UIImageView(frame: CGRect(x: topView.frame.width * CGFloat(i), y: 0, width: topView.frame.width, height: topView.frame.height))
            myImageView.image = UIImage(named: "cat\(i + 1)")
            myImageView.contentMode = .scaleAspectFill
            myScrollView.addSubview(myImageView)
        }
    }
    

    // 滑動結束時
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 左右滑動到新頁時 更新 UIPageControl 顯示的頁數
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = page
    }
    
    // 點擊點點換頁
    func pageChanged(_ sender: UIPageControl) {
        // 依照目前圓點在的頁數算出位置
        var frame = myScrollView.frame
        frame.origin.x = frame.size.width * CGFloat(sender.currentPage)
        frame.origin.y = 0
        
        // 再將 UIScrollView 滑動到該點
        myScrollView.scrollRectToVisible(frame, animated:true)
    }
    

    

}

















