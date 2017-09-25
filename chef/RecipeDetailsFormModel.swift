//
//  RecipeDetailsFormModel.swift
//  chef
//
//  Created by Diwakar Kamboj on 25/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit

class RecipeDetailsFormModel: NSObject {
    private let fields: [RecipeDetailsFormField]
    
    var amount = ""
    var alarmRepetition = [Bool](repeating: false, count: 7)
    
    init(withExistingRecipe recipe: Recipe) {
        self.fields = recipe.formFields
        
        for field in fields {
            switch field {
            case .amountTextField:
                amount = String(recipe.amount)
            case .alarmTimePicker:
                break
            case .alarmRepetitionSelector:
                break
            }
        }
    }
    
    init(forFields fields: [RecipeDetailsFormField]) {
        self.fields = fields
    }
}
