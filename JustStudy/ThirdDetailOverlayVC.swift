//
//  ThirdDetailOverlayVC.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/25.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class ThirdDetailOverlayVC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate {
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    
    @IBOutlet weak var courseLabel: UILabel!
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var comfornBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var orderTimeTexeField: UITextField!
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.bounds.size = CGSize(width: UIScreen.main.bounds.size.width - 110, height: 320)
        self.view.layer.cornerRadius = 10
        //littleView.layer.cornerRadius = 10
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backView.backgroundColor = UIColor.white
        
        backView.layer.cornerRadius = 20
        backView.layer.masksToBounds = true
        
        comfornBtn.layer.borderWidth = 1.0
        comfornBtn.layer.borderColor = UIColor.black.cgColor
        //comfornBtn.layer.cornerRadius = 5
        //comfornBtn.layer.masksToBounds = true
        cancelBtn.layer.borderWidth = 1.0
        cancelBtn.layer.borderColor = UIColor.black.cgColor
        //cancelBtn.layer.cornerRadius = 5
        //cancelBtn.layer.masksToBounds = true
        
        orderTimeTexeField.delegate = self
        
        //加入按一下手勢在view上面，來觸發關鍵盤方法
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    
    @IBAction func comfirnBtn(_ sender: UIButton)
    {
        //消失彈跳視窗
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func cancelBtn(_ sender: UIButton)
    {
        //消失彈跳視窗
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        //建立一個UIDatePicker
        let myDatePicker = UIDatePicker()
        //設置UIDatePickerMode
        myDatePicker.datePickerMode = .dateAndTime
        
        //設置時間顯示格式
        //設置預設日期為今天或出發日期
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        if orderTimeTexeField.text != "" {
            
            let date = dateFormatter.date(from: orderTimeTexeField.text!)
            myDatePicker.date = date!
            textField.text = orderTimeTexeField.text
            
        }else if textField.tag == 1{
            textField.text = dateFormatter.string(from: Date())
        }
        
        //設置顯示的語言環境
        myDatePicker.locale = Locale(identifier: "zh_TW")
        
        //設置改變日期時會執行的動作
        myDatePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
        //orderTimeTexeField.text = dateFormatter.string(from: Date())
        myDatePicker.frame = CGRect(x: 0, y: 0, width: 0, height: 180)
        myDatePicker.backgroundColor = UIColor.darkGray
        myDatePicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        textField.inputView = myDatePicker
        
    }
    
    
    func datePickerChanged(datePicker: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        orderTimeTexeField.text = formatter.string(from: datePicker.date)
    }
    
    func closeKeyboard(){
        self.view.endEditing(true)
    }
    

    

    

}
















