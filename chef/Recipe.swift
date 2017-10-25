//
//  Recipe.swift
//  chef
//
//  Created by Diwakar Kamboj on 20/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit
import RealmSwift

class Recipe: Object {
    var type: RecipeType {
        return RecipeType(rawValue: templateID)!
    }
    
    var formFields: [RecipeDetailsFormField] {
        switch type {
        case .lazySaving:
            return [.amountTextField, .alarmTimePicker, .alarmRepetitionSelector]
        }
    }
    
    dynamic var uuid = NSUUID().uuidString
    dynamic var templateID = 0
    dynamic var isActive = true
    dynamic var amount = 0
    dynamic var alarm: Alarm?
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
}
