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
    
    func addRecent(_ recent : RecentChat) {
        
        do {
            try  FirebaseReference(.Recent).document(recent.id).setData(from: recent)
        } catch {
            print("Error saving recent chat", error.localizedDescription)
        }
       
    }
}
