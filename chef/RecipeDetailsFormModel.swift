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
    var alarmTime = Date()
    var alarmRepetition = [Bool](repeating: true, count: 7)
    
    init(withExistingRecipe recipe: Recipe) {
        self.fields = recipe.formFields
        
        for field in fields {
            switch field {
            case .amountTextField:
                amount = String(recipe.amount)
            case .alarmTimePicker:
                var dateComponents = DateComponents()
                dateComponents.hour = recipe.alarm!.hour
                dateComponents.minute = recipe.alarm!.minute
                alarmTime = Calendar.current.date(from: dateComponents)!
            case .alarmRepetitionSelector:
                for i in 0..<alarmRepetition.count {
                    alarmRepetition[i] = recipe.alarm!.shouldRepeatOnDays[i].value
                }
            }
        }
    }
    
    init(forFields fields: [RecipeDetailsFormField]) {
        self.fields = fields
    }
}
