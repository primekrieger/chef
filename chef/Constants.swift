//
//  Constants.swift
//  chef
//
//  Created by Diwakar Kamboj on 22/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

struct Constants {
    
    struct Strings {
        struct AlertMessages {
            static let title = "Alert"
            static let okAction = "OK"
            static let notificationsPermissionTitle = "Please allow notifications"
            static let notificationsPermissionMessage = "In Settings -> chef, turn on notifications"
            static let settingsAction = "Open Settings"
            static let cancelAction = "Cancel"
        }
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
