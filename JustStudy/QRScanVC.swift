//
//  QRScanVC.swift
//  JustStudy
//
//  Created by Ember on 2017/4/28.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import AVFoundation

class QRScanVC: UIViewController,AVCaptureMetadataOutputObjectsDelegate  {

    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    var audioPlayer = AVAudioPlayer()
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    let supportedCodeTypes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeUPCECode, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeAztecCode, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode39Mod43Code]
    var getValue:String!
    var getTime:String!
    var howManyPeople = [String]()
    var whatTime = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backArrayNotificationName = Notification.Name("sendBackArray")
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getArray(noti:)),
                                               name: backArrayNotificationName,
                                               object: nil)
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf:URL.init(fileURLWithPath: Bundle.main.path(forResource: "beep", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            
        }catch{
            print(error.localizedDescription)
        }
        
        let cptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        do{
            let input = try AVCaptureDeviceInput(device: cptureDevice)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            
            //*****************
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
            //*****************
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            //captureSession?.startRunning()
            
            //*********
            self.view.bringSubview(toFront: listButton)
            self.view.bringSubview(toFront: countLabel)
            
            //*******
            qrCodeFrameView = UIView()
            if let qrCodeFrameView = qrCodeFrameView{
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubview(toFront: qrCodeFrameView)
            }
            
        }catch{
            print(error.localizedDescription)
            return
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        countLabel.text = "\(howManyPeople.count)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        captureSession?.startRunning()
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects == nil || metadataObjects.count == 0{
            qrCodeFrameView?.frame = CGRect.zero
            return
        }
        audioPlayer.play()
        let metadatObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadatObj.type){
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadatObj)
            qrCodeFrameView?.frame = (barCodeObject?.bounds)!
            
            if metadatObj.stringValue != nil{
                
                //show what we get
                getValue = metadatObj.stringValue
                
                let time = NSDate()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
                getTime = "\(dateFormatter.string(from: time as Date))"
                //***********************************************
                
                //#1 ticket verify
                if (getValue?.contains("@justudy#"))!{
                    
                    //#2 member verify
                    if howManyPeople.contains(getValue!){
                        
                        captureSession?.stopRunning()
                        
                        //no need add notify
                        let duplicatedAlert = UIAlertController(title: "重複加入", message: "此人已經報到", preferredStyle: .alert)
                        duplicatedAlert.addAction(UIAlertAction(title: "確定", style: .cancel, handler: { (UIAlertAction) in
                            self.captureSession?.startRunning()
                            self.qrCodeFrameView?.frame = CGRect.zero
                        }))
                        self.present(duplicatedAlert, animated: true, completion: nil)
                    }else{
                        
                        captureSession?.stopRunning()
                        
                        let userInfoArray = getValue!.components(separatedBy: ",")
                        
                        let addAlert = UIAlertController(title: "報到確認", message: "\(userInfoArray[1])", preferredStyle: .alert)
                        addAlert.addAction(UIAlertAction(title: "確定", style: .default, handler: { (UIAlertAction) in
                            
                            print(self.getValue!)
                            self.howManyPeople.append(self.getValue!)
                            self.whatTime.append(self.getTime!)
                            
                            self.countLabel.text = "\(self.howManyPeople.count)"
                            
                            self.captureSession?.startRunning()
                            self.qrCodeFrameView?.frame = CGRect.zero
                        }))
                        
                        addAlert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (UIAlertAction) in
                            
                            self.captureSession?.startRunning()
                            self.qrCodeFrameView?.frame = CGRect.zero
                        }))
                        self.present(addAlert, animated: true, completion: nil)
                    }
                }else{
                    
                    captureSession?.stopRunning()
                    
                    //wrong ticket
                    let wrongAlert = UIAlertController(title: "未知票券", message: "此票券無法辨識", preferredStyle: .alert)
                    wrongAlert.addAction(UIAlertAction(title: "確定", style: .cancel, handler: { (UIAlertAction) in
                        self.captureSession?.startRunning()
                        self.qrCodeFrameView?.frame = CGRect.zero
                    }))
                    self.present(wrongAlert, animated: true, completion: nil)
                    
                }
            }
        }
    }
    
    func getArray(noti: Notification) {
        
        howManyPeople = noti.userInfo!["member"] as! [String]
        whatTime = noti.userInfo!["time"] as! [String]
        
        countLabel.text = "\(howManyPeople.count)"
        print(howManyPeople)
        print(whatTime)
        
    }

    @IBAction func listButton(_ sender: UIButton) {
        
        let dvc = self.storyboard?.instantiateViewController(withIdentifier: "QRListVC") as! QRListVC
        dvc.getMember = howManyPeople
        dvc.getTime = whatTime
        
        captureSession?.stopRunning()
        
        print(dvc.getMember)
        print(dvc.getTime)
       
        self.navigationController?.pushViewController(dvc, animated: true)
    
    }
   
}
