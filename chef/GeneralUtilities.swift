//
//  GeneralUtilities.swift
//  chef
//
//  Created by Diwakar Kamboj on 26/10/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import Foundation

class GeneralUtilities {
    static func getAlarmDetailsString(forAlarm alarm: Alarm) -> String {
        var dateComponents = DateComponents()
        dateComponents.hour = alarm.hour
        dateComponents.minute = alarm.minute
        
        let alarmTime = Calendar.current.date(from: dateComponents)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        let alarmTimeString = dateFormatter.string(from: alarmTime!)
        
        var repeatDays = String()
        var lastActiveRepetitionDay: String?
        var lastInactiveRepetitionDay: String?
        let inactiveRepetitionDaySymbol = "•"
        
        for i in 0..<alarm.shouldRepeatOnDays.count {
            if alarm.shouldRepeatOnDays[i].value {
                repeatDays.append(dateFormatter.veryShortWeekdaySymbols[i])
                lastActiveRepetitionDay = dateFormatter.weekdaySymbols[i]
            } else {
                repeatDays.append(inactiveRepetitionDaySymbol)
                lastInactiveRepetitionDay = dateFormatter.weekdaySymbols[i]
            }
        }
        
        let repeatDaysTrimmed = repeatDays.replacingOccurrences(of: inactiveRepetitionDaySymbol, with: "")
        
        if repeatDaysTrimmed.count == 1 {
            repeatDays = "Every " + lastActiveRepetitionDay!
        } else if repeatDaysTrimmed.count == 6 {
            repeatDays = "Except " + lastInactiveRepetitionDay!
        } else if repeatDaysTrimmed == "SMTWTFS" {
            repeatDays = "Every day"
        } else if repeatDaysTrimmed == "SS" {
            repeatDays = "Weekends"
        } else if repeatDaysTrimmed == "MTWTF" {
            repeatDays = "Weekdays"
        }
        
        return alarmTimeString + ", " + repeatDays
    }
}
