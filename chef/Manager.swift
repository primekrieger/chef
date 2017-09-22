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
    
    func createRecipe(_ recipe: Recipe) {
        PersistenceManager.shared.save(recipe)
    }
    
    func getRecipes(filter: RecipeFilter) -> Results<Recipe> {
        return PersistenceManager.shared.getRecipes(filter: filter)
    }
}
