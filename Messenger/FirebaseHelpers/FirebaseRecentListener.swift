//
//  FirebaseRecentListener.swift
//  Messenger
//
//  Created by Mahmudul Hasan on 22/3/23.
//

import Foundation
import Firebase

class FirebaseRecentListener {
    
    static let shared = FirebaseRecentListener()
    
    private init() {}
    
    func downloadRecentChatsFromFireStore(completion: @escaping(_ allRecents: [RecentChat]) -> Void) {
        FirebaseReference(.Recent).whereField(kSENDERID, isEqualTo: User.currentId).addSnapshotListener { (querySnapshot, error) in
        
            var recentChats: [RecentChat] = []
            
            guard let documents = querySnapshot?.documents else {
                print("No documents for recent chats")
                
                return
            }
            
            let allRecents = documents.compactMap { (queryDocumentsSnapshot) -> RecentChat? in
                return try? queryDocumentsSnapshot.data(as: RecentChat.self)
            
            }
            
            for recent in allRecents {
                if recent.lastMessage != "" {
                    recentChats.append(recent)
                }
            }
            
            recentChats.sort(by:{$0.date! > $1.date!})
            completion(recentChats)
        }
    }
    
    func resetRecentCounter(chatRoomId: String) {
        
        FirebaseReference(.Recent).whereField(kCHATROOMID, isEqualTo: chatRoomId).whereField(kSENDERID, isEqualTo: User.currentId).getDocuments {(querySnapshot, error) in
            
            guard let documents = querySnapshot?.documents else {
                print("No documents for recent")
                return
            }
            let allRecent = documents.compactMap { (queryDocumentSnapshot) -> RecentChat? in
                
                return try? queryDocumentSnapshot.data(as: RecentChat.self)
            }
            
            if allRecent.count > 0 {
                self.clearUnreadCounter(recent: allRecent.first!)
            }
        }
    }
    
    func updateRecents(chatRoomId: String, lastMessage: String) {
        
        FirebaseReference(.Recent).whereField(kCHATROOMID, isEqualTo: chatRoomId).getDocuments {(querySnapshot, error) in
            
            guard let documents = querySnapshot?.documents else {
                print("No documents for recent update")
                return
            }
            
            let allRecents = documents.compactMap { (queryDocumentSnapshot) -> RecentChat? in
                
                return try? queryDocumentSnapshot.data(as: RecentChat.self)
            }
            
            for recentChat in allRecents {
                self.updateRecentItemWithNewMessage(recent: recentChat, lastMessage: lastMessage)
            }
            
            
        }
    }

    private func updateRecentItemWithNewMessage(recent: RecentChat, lastMessage: String) {
        
        var tempRecent = recent
        
        if tempRecent.senderId != User.currentId {
            tempRecent.unreadCounter += 1
        }
        
        tempRecent.lastMessage = lastMessage
        tempRecent.date = Date()
        
        self.saveRecent(tempRecent)
    }
    
    
    func clearUnreadCounter(recent: RecentChat) {
        var newRecent = recent
        newRecent.unreadCounter = 0
        self.saveRecent(newRecent)
        
    }
    
    
    func saveRecent(_ recent : RecentChat) {
        
        do {
            try  FirebaseReference(.Recent).document(recent.id).setData(from: recent)
        } catch {
            print("Error saving recent chat", error.localizedDescription)
        }
       
    }
    
    func deleteRecent(_ recent: RecentChat) {
        
        FirebaseReference(.Recent).document(recent.id).delete()
    }
}
