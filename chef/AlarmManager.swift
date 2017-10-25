//
//  AlarmManager.swift
//  chef
//
//  Created by Diwakar Kamboj on 02/10/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit
import UserNotifications

class AlarmManager: NSObject {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func scheduleAlarm(forRecipe recipe: Recipe) {
        removeAlarm(alarmUUID: recipe.alarm!.uuid)
        setAlarm(forRecipe: recipe)
    }
    
    func snooze(alarmRequestIdentifier: String, recipeIdentifier: String) {
        let alarmNotificationContent = createAlarmNotificationContent()
        alarmNotificationContent.userInfo = [Constants.Keys.recipeIdentifier: recipeIdentifier]
        
        let snoozeAlarmDate = Date(timeIntervalSinceNow: 5 * 60)
        
        var dateInfo = DateComponents()
        dateInfo.hour = Calendar.current.component(.hour, from: snoozeAlarmDate)
        dateInfo.minute = Calendar.current.component(.minute, from: snoozeAlarmDate)
        
        var alarmIdentifier = alarmRequestIdentifier
        if alarmRequestIdentifier.substring(from: alarmRequestIdentifier.index(alarmRequestIdentifier.endIndex, offsetBy: -Constants.Alarm.snoozeSuffix.count)) != Constants.Alarm.snoozeSuffix {
            alarmIdentifier.append(Constants.Alarm.snoozeSuffix)
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
        let request = UNNotificationRequest(identifier: alarmIdentifier, content: alarmNotificationContent, trigger: trigger)
        
        notificationCenter.add(request) { (error: Error?) in
            if let someError = error {
                print(someError.localizedDescription)
            }
        }
    }
    
    func removeAlarm(alarmUUID: String) {
        var notificationIdentifiers = [String]()
        for i in 0..<7 {
            notificationIdentifiers.append(alarmUUID + String(i))
        }
        notificationCenter.removePendingNotificationRequests(withIdentifiers: notificationIdentifiers)
    }
    
    private func setAlarm(forRecipe recipe: Recipe) {
        let alarm = recipe.alarm!
        
        let alarmNotificationContent = createAlarmNotificationContent()
        alarmNotificationContent.userInfo = [Constants.Keys.recipeIdentifier: recipe.uuid]
        
        var dateInfo = DateComponents()
        dateInfo.hour = alarm.hour
        dateInfo.minute = alarm.minute
        
        for i in 0..<alarm.shouldRepeatOnDays.count {
            if alarm.shouldRepeatOnDays[i].value {
                dateInfo.weekday = i + 1
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
                let request = UNNotificationRequest(identifier: alarm.uuid + String(i), content: alarmNotificationContent, trigger: trigger)
                
                notificationCenter.add(request) { (error: Error?) in
                    if let someError = error {
                        print(someError.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func createAlarmNotificationContent() -> UNMutableNotificationContent {
        let alarmNotificationContent = UNMutableNotificationContent()
        alarmNotificationContent.title = Constants.Alarm.title
        alarmNotificationContent.body = Constants.Alarm.body
        alarmNotificationContent.categoryIdentifier = Constants.Alarm.categoryIdentifier
        alarmNotificationContent.sound = UNNotificationSound.default()
        return alarmNotificationContent
    }
    
}
