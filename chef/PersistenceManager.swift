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
    
    func save(_ object: Object) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func getRecipes(active: Bool) -> Results<Recipe> {
        let realm = try! Realm()
        
        return realm.objects(Recipe.self).filter("active = \(active.description)")
        
    }
    
}
