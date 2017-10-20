//
//  Enums.swift
//  chef
//
//  Created by Diwakar Kamboj on 21/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

enum RecipeFilter {
    case all, active, inactive
}

enum RecipeDetailsFormField {
    case amountTextField, alarmTimePicker, alarmRepetitionSelector
}

enum RecipeType: Int {
    case lazySaving = 1001
    
    var displayName: String {
        switch self {
        case .lazySaving:
            return "Lazy Saving"
        }
    }
}
