//
//  AppSettings.swift
//  chef
//
//  Created by Diwakar Kamboj on 02/10/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit

class AppSettings: NSObject {
    static let shared = AppSettings()
    
    private override init() {
        super.init()
        UserDefaults.standard.register(defaults: [
            Constants.Keys.UserDefaults.isFirstLaunch: true
            ])
    }
    
    var isFirstLaunch: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Constants.Keys.UserDefaults.isFirstLaunch)
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: Constants.Keys.UserDefaults.isFirstLaunch)
        }
    }
}
