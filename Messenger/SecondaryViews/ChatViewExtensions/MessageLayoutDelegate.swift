//
//  MessageLayoutDelegate.swift
//  Messenger
//
//  Created by Mahmudul Hasan on 26/3/23.
//

import Foundation
import MessageKit

extension ChatViewController: MessagesLayoutDelegate {
    
    //MARK: - Cell top label
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
    
        //TODO: set different size for pull to reload
        
        if indexPath.section % 3 == 0 {
            
            return 18
        }
        
        return 0
        
    }
    
    func cellBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return isFromCurrentSender(message: message) ? 17 : 0
    }
    
    //MARK: - Message Bottom Lebel
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return indexPath.section != mkMessages.count - 1 ? 10 : 0
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        avatarView.set(avatar: Avatar(initials: mkMessages[indexPath.section].senderInitials))
    }
}
