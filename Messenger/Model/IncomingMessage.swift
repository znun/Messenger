//
//  IncomingMessage.swift
//  Messenger
//
//  Created by Mahmudul Hasan on 30/3/23.
//

import Foundation
import MessageKit
import CoreLocation

class IncomingMessage {
    var messageCollectionView: MessagesViewController
    
    init(_collectionView: MessagesViewController) {
        messageCollectionView = _collectionView
    }
    
    //MARK: - CreateMessage
    
    func createMessage(localMessage: LocalMessage) -> MkMessage {
        
        let mkMessage = MkMessage(message: localMessage)
        
        //Multimedia Messages
        
        return mkMessage
    }
}

