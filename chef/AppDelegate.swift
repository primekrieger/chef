//
//  AppDelegate.swift
//  chef
//
//  Created by Diwakar Kamboj on 19/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if AppSettings.shared.isFirstLaunch {
            AppSettings.shared.isFirstLaunch = false
            setupMockData()
        }
        askNotificationsPermission()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    private func setupMockData() {
        let lazySavingRecipe = RecipeTemplate(type: .lazySaving,
                                               shortDescription: "Pay up each time you snooze on a wake up alarm. Guilty Pleasures.")
        
        Manager.shared.createMockData([lazySavingRecipe])
    }
    
    private func askNotificationsPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if !granted {
                self.displayPermissionAlert()
            }
        }
    }
    
    private func displayPermissionAlert() {
        let alert = UIAlertController(title: Constants.Strings.AlertMessages.notificationsPermissionTitle, message: Constants.Strings.AlertMessages.notificationsPermissionMessage, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: Constants.Strings.AlertMessages.settingsAction, style: .default, handler: { _ in
            guard let settingsURL = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL)
            }
        })
        alert.addAction(settingsAction)
        
        let cancelAction = UIAlertAction(title: Constants.Strings.AlertMessages.cancelAction, style: .default, handler: nil)
        alert.addAction(cancelAction)
        window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}

