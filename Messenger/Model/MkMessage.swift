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
    
    var status: String
    var readData: Date
    
    init(message: String) {
        
    }
}
