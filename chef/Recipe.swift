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
    
    var displayName: String {
        switch type {
        case .lazySaving:
            return "Lazy Saving"
        }
    }
    
    var formFields: [RecipeDetailsFormField] {
        switch type {
        case .lazySaving:
            return [.amountTextField, .alarmTimePicker, .alarmRepetitionSelector]
        }
    }
    
    dynamic var amount = 0
    dynamic var active = true
    dynamic var templateID = 0
    dynamic var alarm: Alarm?
}
