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
        savedAmountLabel.text = recipe.savedAmount.rupeeString()
        
        switch recipe.type {
        case .lazySaving:
            let alarmDetails = GeneralUtilities.getAlarmDetailsString(forAlarm: recipe.alarm!)
            keyActionLabel.text = "Alarm - \(alarmDetails)"
            amountLabel.text = "Pay up \(recipe.amount.rupeeString()) on each snooze"
        }
    }
    
}
