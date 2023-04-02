//
//  FirebaseTypingListener.swift
//  Messenger
//
//  Created by Mahmudul Hasan on 2/4/23.
//

import Foundation
import Firebase
import FirebaseFirestore

//class FirebaseTypingListener {
//
//    static let shared = FirebaseTypingListener()
//
//    var typingListener: ListenerRegistration!
//
//    private init() {}
//
//    func createTypingObserver(chatroomId: String, completion: (Bool)) -> Void {
//
//        typingListener = FirebaseReference(.Typing).document(chatroomId).addSnapshotListener({ (snapshot, error) in
//
//            guard let snapshot = snapshot else {return}
//
//            if snapshot.exists {
//
//                for data in snapshot.data()! {
//
//                    if data.key != User.currentId {
//                        //completion(data.value as! Bool)
//                    }
//                }
//            } else {
//
//            }
//        })
//    }
    
//}
