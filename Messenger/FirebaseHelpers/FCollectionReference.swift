//
//  FCollectionReference.swift
//  Messenger
//
//  Created by Mahmudul Hasan on 12/3/23.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String{
    case User
    case Recent
    case Messages
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference{
    
    return Firestore.firestore().collection(collectionReference.rawValue)
}
