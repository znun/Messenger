//
//  MkMessage.swift
//  Messenger
//
//  Created by Mahmudul Hasan on 27/3/23.
//

import Foundation
import MessageKit
import CoreLocation

class MkMessage: NSObject, MessageType {
    
    var messageId: String
    var kind: MessageKind
    var sentDate: Date
    var incoming: Bool
    var mkSender: MKSender
    var sender: SenderType {return mkSender}
    var senderInitials: String
    
    var photoItem: PhotoMessage?
    var videoItem: VideoMessage?
    
    var status: String
    var readData: Date
    
    init(message: LocalMessage) {
        
        self.messageId = message.id
        
        self.mkSender = MKSender(senderId: message.senderId, displayName: message.senderName)
        self.status = message.status
        self.kind = MessageKind.text(message.message)
        
        switch message.type {
        case kTEXT:
            self.kind = MessageKind.text(message.message)
         
        case kPHOTO:
            
            let photoItem = PhotoMessage(path: message.pictureUrl)
            self.kind = MessageKind.photo(photoItem)
            self.photoItem = photoItem
        
        case kVIDEO:
            
            let videoItem = VideoMessage(url: nil)
            self.kind = MessageKind.video(videoItem)
            self.videoItem = videoItem
            
        default:
            print("Unknown Message")
        }
        
        self.senderInitials = message.senderInitials
        self.sentDate = message.date
        self.readData = message.readDate
        self.incoming = User.currentId != mkSender.senderId
    }
}
