//
//  Manager.swift
//  chef
//
//  Created by Diwakar Kamboj on 20/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit
import RealmSwift

class Manager: NSObject {
    static let shared = Manager()
    
    func saveRecipe(_ recipe: Recipe) {
        PersistenceManager.shared.save([recipe], update: true)
        
        switch recipe.type {
        case .lazySaving:
            AlarmManager().scheduleAlarm(recipe.alarm!)
        }
    }
    
    func getRecipes(filter: RecipeFilter) -> Results<Recipe> {
        return PersistenceManager.shared.getRecipes(filter: filter)
    }
    
    func getRecipeTemplates() -> Results<RecipeTemplate> {
        return PersistenceManager.shared.getRecipeTemplates()
    }
    
    func createMockData(_ objects: [Object]) {
        PersistenceManager.shared.save(objects, update: false)
    }
}
