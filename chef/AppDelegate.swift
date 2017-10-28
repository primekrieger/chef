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
        UNUserNotificationCenter.current().delegate = self
        setNotificationCategory()
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
    
    private func setNotificationCategory() {
        let snoozeAction = UNNotificationAction(identifier: Constants.Alarm.snoozeActionIdentifier,
                                                title: Constants.Alarm.snoozeActionTitle,
                                                options: UNNotificationActionOptions(rawValue: 0))
        let stopAction = UNNotificationAction(identifier: Constants.Alarm.stopActionIdentifier,
                                              title: Constants.Alarm.stopActionTitle,
                                              options: .destructive)
        let alarmCategory = UNNotificationCategory(identifier: Constants.Alarm.categoryIdentifier,
                                                     actions: [snoozeAction, stopAction],
                                                     intentIdentifiers: [],
                                                     options: .customDismissAction)
        UNUserNotificationCenter.current().setNotificationCategories([alarmCategory])
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
        case Constants.Alarm.snoozeActionIdentifier, UNNotificationDismissActionIdentifier:
            let notificationRequest = response.notification.request
            let recipeIdentifier = notificationRequest.content.userInfo[Constants.Keys.recipeIdentifier] as! String
            Manager.shared.snoozeAlarm(alarmRequestIdentifier: notificationRequest.identifier, recipeIdentifier: recipeIdentifier)
        default:
            break
        }
        completionHandler()
    }
}

