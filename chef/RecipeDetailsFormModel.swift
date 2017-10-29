//
//  RecipeDetailsFormModel.swift
//  chef
//
//  Created by Diwakar Kamboj on 25/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit

class RecipeDetailsFormModel: NSObject {
    let fields: [RecipeDetailsFormField]
    
    var amountString = String()
    var alarmTime = Date()
    var shouldRepeatAlarmOnDays = [false, true, true, true, true, true, false]
    
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
                let minAmount = 50
                let maxAmount = 1000
                let amount = Int(amountString.trimmingCharacters(in: .whitespaces))
                if amount == nil || amount! < minAmount || amount! > maxAmount {
                    return (false, "Please enter an amount between \(minAmount.toRupeeString()) and \(maxAmount.toRupeeString()).")
                }
            case .alarmTimePicker:
                break
            case .alarmRepetitionSelector:
                for shouldRepeatOnDay in shouldRepeatAlarmOnDays {
                    if shouldRepeatOnDay {
                        break validateField
                    }
                }
                return (false, "Please select at least one day for alarm repetition.")
            }
        }
        return (true, nil)
    }
}
