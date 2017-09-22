//
//  AvailableRecipe.swift
//  chef
//
//  Created by Diwakar Kamboj on 22/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit
import RealmSwift

class AvailableRecipe: Object {
    dynamic var type = 0
    dynamic var name = ""
    dynamic var shortDescription = ""
    
    convenience init(type: RecipeType, name: String, shortDescription: String) {
        self.init()
        self.type = type.rawValue
        self.name = name
        self.shortDescription = shortDescription
    }
}
