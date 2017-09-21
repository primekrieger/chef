//
//  PersistenceManager.swift
//  chef
//
//  Created by Diwakar Kamboj on 20/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit
import RealmSwift

class PersistenceManager: NSObject {
    static let shared = PersistenceManager()
    
    var realm: Realm?
    
    private func getRealm() -> Realm? {
        if realm != nil {
            return realm
        } else {
            realm = createNewRealm()
            return realm
        }
    }
    
    private func createNewRealm() -> Realm? {
        do {
            let newRealm = try Realm()
            return newRealm
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
    
    func saveRealmObject(object: Object) {
        
    }
}
