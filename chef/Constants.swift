//
//  Constants.swift
//  chef
//
//  Created by Diwakar Kamboj on 22/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit

struct Constants {
    
    struct Strings {
        struct AlertMessages {
            static let validationErrorTitle = "Uh-oh!"
            static let okAction = "OK"
            static let notificationsPermissionTitle = "Please allow notifications"
            static let notificationsPermissionMessage = "In Settings -> chef, turn on notifications"
            static let settingsAction = "Open Settings"
            static let cancelAction = "Cancel"
        }
        
        struct FormCells {
            static let amountTextFieldLabel = "Each action is worth"
            static let amountTextFieldPlaceholder = "Enter an amount"
            static let alarmTimePickerLabel = "Alarm time"
        }
        
        static let activateRecipeButtonTitle = "Activate"
        static let noActiveRecipesLabel = "No active recipes at the moment.\nPick a recipe to get started."
        static let noInactiveRecipesLabel = "No inactive recipes."
        static let inputToolbarDoneButtonTitle = "Done"
        static let rupeeSymbol = "₹"
        static let nonBreakingSpace = " "
    }
    
    struct Locales {
        static let englishIndia = Locale(identifier: "en_IN")
    }
    
    struct Keys {
        struct UserDefaults {
            static let isFirstLaunch = "isFirstLaunch"
        }
        static let recipeIdentifier = "recipeIdentifier"
    }
    
    struct Storyboards {
        static let main = "Main"
    }
    
    struct Colors {
        static let inactiveGray = UIColor(hex: "DDDDDD")
        static let borderGray = UIColor(hex: "CCCCCC")
    }
    
    struct Alarm {
        static let title = "Wake up!"
        static let body = "Rise and shine! It's morning time!"
        static let categoryIdentifier = "CHEF_ALARM"
        static let snoozeActionIdentifier = "SNOOZE_ACTION"
        static let stopActionIdentifier = "STOP_ACTION"
        static let snoozeActionTitle = "Snooze"
        static let stopActionTitle = "Stop"
        static let snoozeSuffix = "Snooze"
    }
}
