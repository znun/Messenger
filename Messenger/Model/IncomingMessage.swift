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
        
        if localMessage.type == kPHOTO {
            
            let photoitem = PhotoMessage(path: localMessage.pictureUrl)
            
            mkMessage.photoItem = photoitem
            mkMessage.kind = MessageKind.photo(photoitem)
            
            FileStorage.downloadImage(imageUrl: localMessage.pictureUrl) { (image) in
                
                mkMessage.photoItem?.image = image
                self.messageCollectionView.messagesCollectionView.reloadData()
            }
        }
        
        return mkMessage
    }
}

