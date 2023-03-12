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
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> FCollectionReference{
    
    return Firestore.firestore().collection(collectionReference.rawValue)
}
