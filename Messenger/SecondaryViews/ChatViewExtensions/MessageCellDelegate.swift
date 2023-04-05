//
//  MessageCellDelegate.swift
//  Messenger
//
//  Created by Mahmudul Hasan on 26/3/23.
//

import Foundation
import MessageKit
import AVFoundation
import AVKit
import SKPhotoBrowser

extension ChatViewController: MessageCellDelegate {
    
    func didTapImage(in cell: MessageCollectionViewCell) {
        
        if let indexPath = messagesCollectionView.indexPath(for: cell) {
            let mkMessage = mkMessages[indexPath.section]

            if mkMessage.photoItem != nil && mkMessage.photoItem!.image != nil {
                
               var image = [SKPhoto]()
               let photo = SKPhoto.photoWithImage(mkMessage.photoItem!.image!)
               image.append(photo)
                
               let browser = SKPhotoBrowser(photos: image)
               browser.initializePageIndex(0)
               present(browser, animated: true, completion: nil)
            }
            
            if mkMessage.videoItem != nil && mkMessage.videoItem!.url != nil {
                
                let player = AVPlayer(url: mkMessage.videoItem!.url!)
                let moviePlayer = AVPlayerViewController()
                
                let session = AVAudioSession.sharedInstance()
                
                try! session.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
                
                moviePlayer.player = player
                
                self.present(moviePlayer, animated: true) {
                    moviePlayer.player!.play()
                }
            }
        }
        
    }
}
