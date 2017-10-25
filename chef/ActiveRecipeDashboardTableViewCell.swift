//
//  ActiveRecipeDashboardTableViewCell.swift
//  chef
//
//  Created by Diwakar Kamboj on 21/10/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit

class ActiveRecipeDashboardTableViewCell: UITableViewCell {
    
    static let nibName = "ActiveRecipeDashboardTableViewCell"
    static let cellReuseIdentifier = "activeRecipeDashboardTableViewCell"

    @IBOutlet weak private var recipeNameLabel: UILabel!
    @IBOutlet weak private var savedAmountLabel: UILabel!
    @IBOutlet weak private var keyActionLabel: UILabel!
    @IBOutlet weak private var amountLabel: UILabel!
    
    func setup(withRecipe recipe: Recipe) {
        recipeNameLabel.text = recipe.type.displayName
        savedAmountLabel.text = "₹\(recipe.savedAmount)"
        
        switch recipe.type {
        case .lazySaving:
            let alarmDetails = getAlarmDetailsString(forAlarm: recipe.alarm!)
            keyActionLabel.text = "Alarm - \(alarmDetails)"
            amountLabel.text = "Pay up ₹\(recipe.amount) on each snooze"
        }
    }
    
    private func getAlarmDetailsString(forAlarm alarm: Alarm) -> String {
        var dateComponents = DateComponents()
        dateComponents.hour = alarm.hour
        dateComponents.minute = alarm.minute
        
        let alarmTime = Calendar.current.date(from: dateComponents)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        let alarmTimeString = dateFormatter.string(from: alarmTime!)
        
        var repeatDays = String()
        
        var repetitionCount = 0
        var lastRepetitionDay: String!
        
        for i in 0..<alarm.shouldRepeatOnDays.count {
            if alarm.shouldRepeatOnDays[i].value {
                repetitionCount += 1
                switch i {
                case 0:
                    repeatDays.append("Su ")
                    lastRepetitionDay = "Sunday"
                case 1:
                    repeatDays.append("Mo ")
                    lastRepetitionDay = "Monday"
                case 2:
                    repeatDays.append("Tu ")
                    lastRepetitionDay = "Tuesday"
                case 3:
                    repeatDays.append("We ")
                    lastRepetitionDay = "Wednesday"
                case 4:
                    repeatDays.append("Th ")
                    lastRepetitionDay = "Thursday"
                case 5:
                    repeatDays.append("Fr ")
                    lastRepetitionDay = "Friday"
                case 6:
                    repeatDays.append("Sa ")
                    lastRepetitionDay = "Saturday"
                default:
                    break
                }
            }
        }
        
        if repetitionCount == 1 {
            repeatDays = "Every " + lastRepetitionDay
        } else if repeatDays == "Su Mo Tu We Th Fr Sa " {
            repeatDays = "Every day"
        } else if repeatDays == "Su Sa " {
            repeatDays = "Weekends"
        } else if repeatDays == "Mo Tu We Th Fr " {
            repeatDays = "Weekdays"
        }
        
        return alarmTimeString + ", " + repeatDays
    }
    
}
