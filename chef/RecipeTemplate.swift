//
//  RecipeTemplate.swift
//  chef
//
//  Created by Diwakar Kamboj on 23/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit
import RealmSwift

class RecipeTemplate: Object {
    dynamic var type = 0
    dynamic var shortDescription = ""
    
    convenience init(type: RecipeType, shortDescription: String) {
        self.init()
        self.type = type.rawValue
        self.shortDescription = shortDescription
    }
}
