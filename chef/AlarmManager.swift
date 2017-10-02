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
    static let shared = AlarmManager()
    
    func scheduleAlarm(_ alarm: Alarm) {
        removeAlarm(alarmUUID: alarm.uuid)
        setAlarm(alarm)
    }
    
    private func removeAlarm(alarmUUID: String) {
        var notificationIdentifiers = [String]()
        for i in 0..<7 {
            notificationIdentifiers.append(alarmUUID + String(i))
        }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: notificationIdentifiers)
    }
    
    private func setAlarm(_ alarm: Alarm) {
        let alarmNotificationContent = UNMutableNotificationContent()
        alarmNotificationContent.title = Constants.Alarm.title
        alarmNotificationContent.body = Constants.Alarm.body
        
        alarmNotificationContent.categoryIdentifier = Constants.Alarm.category
        
        alarmNotificationContent.sound = UNNotificationSound.default()
        
        var dateInfo = DateComponents()
        dateInfo.hour = alarm.hour
        dateInfo.minute = alarm.minute
        
        let center = UNUserNotificationCenter.current()
        
        for i in 0..<alarm.shouldRepeatOnDays.count {
            if alarm.shouldRepeatOnDays[i].value {
                dateInfo.weekday = i + 1
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
                let request = UNNotificationRequest(identifier: alarm.uuid + String(i), content: alarmNotificationContent, trigger: trigger)
                
                center.add(request) { (error: Error?) in
                    if let someError = error {
                        print(someError.localizedDescription)
                    }
                }
            }
        }
    }
}
