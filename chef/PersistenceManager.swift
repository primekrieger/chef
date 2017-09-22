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
    
    func save(_ objects: [Object]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(objects)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func getRecipes(filter: RecipeFilter) -> Results<Recipe> {
        let queryString: String
        let realm = try! Realm()
        
        switch filter {
        case .all:
            return realm.objects(Recipe.self)
        case .active:
            queryString = "active = true"
        case .inactive:
            queryString = "active = false"
        }
        
        return realm.objects(Recipe.self).filter(queryString)
    }
    
    func getAvailableRecipes() -> Results<AvailableRecipe> {
        let realm = try! Realm()
        return realm.objects(AvailableRecipe.self)
    }
    
}
