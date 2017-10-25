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
    
    func save(_ objects: [Object], update: Bool) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(objects, update: update)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func toggleRecipeActiveState(forRecipe recipe: Recipe) {
        do {
            let realm = try Realm()
            try realm.write {
                recipe.isActive = !recipe.isActive
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
            queryString = "isActive = true"
        case .inactive:
            queryString = "isActive = false"
        }
        
        return realm.objects(Recipe.self).filter(queryString)
    }
    
    func getRecipeTemplates() -> Results<RecipeTemplate> {
        let realm = try! Realm()
        return realm.objects(RecipeTemplate.self)
    }
    
}
