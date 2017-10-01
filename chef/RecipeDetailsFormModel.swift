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
    
    var amountString = ""
    var alarmTime = Date()
    var shouldRepeatAlarmOnDays = [Bool](repeating: true, count: 7)
    
    init(withExistingRecipe recipe: Recipe) {
        self.fields = recipe.formFields
        
        for field in fields {
            switch field {
            case .amountTextField:
                amountString = String(recipe.amount)
            case .alarmTimePicker:
                var dateComponents = DateComponents()
                dateComponents.hour = recipe.alarm!.hour
                dateComponents.minute = recipe.alarm!.minute
                alarmTime = Calendar.current.date(from: dateComponents)!
            case .alarmRepetitionSelector:
                for i in 0..<shouldRepeatAlarmOnDays.count {
                    shouldRepeatAlarmOnDays[i] = recipe.alarm!.shouldRepeatOnDays[i].value
                }
            }
        }
    }
    
    init(forFields fields: [RecipeDetailsFormField]) {
        self.fields = fields
    }
    
    func validate() -> (success: Bool, errorString: String?) {
        for field in fields {
            validateField: switch field {
            case .amountTextField:
                let amount = Int(amountString.trimmingCharacters(in: .whitespaces))
                if amount == nil || amount! < 250 || amount! > 1000 {
                    return (false, "Please enter an amount between 250 and 1000")
                }
            case .alarmTimePicker:
                break
            case .alarmRepetitionSelector:
                for shouldRepeatOnDay in shouldRepeatAlarmOnDays {
                    if shouldRepeatOnDay {
                        break validateField
                    }
                }
                return (false, "Please select at least one day for alarm repetition")
            }
        }
        return (true, nil)
    }
}
