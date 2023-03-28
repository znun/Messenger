//
//  RealmManager.swift
//  Messenger
//
//  Created by Mahmudul Hasan on 28/3/23.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    let realm = try! Realm()
    
    private init() {}
    
    func saveToRealm<T: Object>(_ object: T) {
        
        do {
            try realm.write {
                realm.add(object, update: .all)
            }
        } catch {
            print("Error saving Realm object", error.localizedDescription)
        }
    }
}
