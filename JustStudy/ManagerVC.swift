//
//  ManagerVC.swift
//  JustStudy
//
//  Created by Ember on 2017/4/26.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Firebase

class ManagerVC: JSQMessagesViewController {

    var key:String!
    
    let ref = FIRDatabase.database().reference()
    var messageArray:[Dictionary<String,AnyObject>] = [] //for message
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //關閉附件
        self.inputToolbar.contentView?.leftBarButtonItem = nil
        
        //對方與自己的頭像
        collectionView?.collectionViewLayout.incomingAvatarViewSize = .zero
        collectionView?.collectionViewLayout.outgoingAvatarViewSize = .zero
        
        //塞對話內容
        ref.child("chat/\(key!)").observe(.childAdded, with: { (snapShots) in
            if let snapShot = snapShots.value as? Dictionary<String,AnyObject>{
                self.messageArray.append(snapShot)
                self.finishReceivingMessage()
            }
        })
    }
    
    //寄訊息的UID，送訊息用
    override func senderId() -> String {
        return FIRAuth.auth()!.currentUser!.uid
    }
    
    //寄訊息的人，送訊息用
    override func senderDisplayName() -> String {
        return "JS_Manager"
    }
    
    //分析message
    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageDataForItemAt indexPath: IndexPath) -> JSQMessageData {
        
        let messageDict = self.messageArray[indexPath.row]
        
        guard let senderId = messageDict["senderId"] as? String,
            let senderDisplayName = messageDict["senderDisplayName"] as? String,
            let date = messageDict["date"] as? TimeInterval,
            let text = messageDict["text"] as? String else {
                let jsqmData = JSQMessage(senderId: "", senderDisplayName: "", date: Date(), text: "")
                return jsqmData
        }
        let time = Date(timeIntervalSince1970: date)
        let jsqmData = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: time, text: text)
        return jsqmData
    }
    
    override func didPressSend(_ button: UIButton, withMessageText text: String, senderId: String, senderDisplayName: String, date: Date) {
        //每句話都要有ID，使用上面資訊
        let randomID = ref.child("chat/\(key!)").childByAutoId()
        randomID.setValue(["text":text,
                           "senderId":senderId,
                           "senderDisplayName":senderDisplayName,
                           "date": date.timeIntervalSince1970]) { (error, ref) in
                            
                            self.finishSendingMessage()
                            
        }
    }
    
    
    
    //bubble message
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageBubbleImageDataForItemAt indexPath: IndexPath) -> JSQMessageBubbleImageDataSource? {
        let messageDict = messageArray[indexPath.row]
        let factory = JSQMessagesBubbleImageFactory()
        if messageDict["senderId"] as! String == FIRAuth.auth()!.currentUser!.uid{
            return factory.outgoingMessagesBubbleImage(with: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        }else{
            return factory.incomingMessagesBubbleImage(with: UIColor.lightGray)
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath) -> NSAttributedString? {
        let messageDict = messageArray[indexPath.row]
        let name = messageDict["senderDisplayName"] as! String
        let date = messageDict["date"] as! TimeInterval
        
        let dateFormatter = DateFormatter() //時間轉型
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //時間格式設定，大小寫有不同含意
        let time = dateFormatter.string(from: Date(timeIntervalSince1970: date))
        let bubbleString = "\(name) - \(time)"
        return NSAttributedString(string: bubbleString)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout, heightForMessageBubbleTopLabelAt indexPath: IndexPath) -> CGFloat {
        return 15
    }
    
}
