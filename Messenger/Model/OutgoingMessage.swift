//
//  OutgoingMessage.swift
//  Messenger
//
//  Created by Mahmudul Hasan on 28/3/23.
//

import Foundation
import UIKit
import FirebaseFirestoreSwift

class OutgoingMessage {
    
    class func send(chatId: String, text: String?, photo: UIImage?, video: String?, audio: String?, audioDuration: Float? = 0.0, location: String, memberIds: [String]) {
        
        let currentUser = User.currentUser!
        
        let message = LocalMessage()
        message.id = UUID().uuidString
        message.chatRoomId = chatId
        message.senderId = currentUser.id
        message.senderName = currentUser.username
        message.senderInitials = String(currentUser.username.first!)
        message.date = Date()
        message.status = kSENT
        
        if text != nil {
            
            sendTextMessage(message: message, text: text!, memberIds: memberIds)
            //send text message
        }
        
        //TODO: Send Push notification
        //TODO: Update recent
    }
}

func sendTextMessage(message: LocalMessage, text: String, memberIds: [String]) {
    
    message.message = text
    message.type = kTEXT
}
