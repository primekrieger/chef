//
//  InactiveRecipeDashboardTableViewCell.swift
//  chef
//
//  Created by Diwakar Kamboj on 21/10/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit

class InactiveRecipeDashboardTableViewCell: UITableViewCell {
    
    static let nibName = "InactiveRecipeDashboardTableViewCell"
    static let cellReuseIdentifier = "inactiveRecipeDashboardTableViewCell"

    @IBOutlet weak private var recipeNameLabel: UILabel!
    @IBOutlet weak private var savedAmountLabel: UILabel!
    @IBOutlet weak private var keyActionLabel: UILabel!
    
    func setup(withRecipe recipe: Recipe) {
        recipeNameLabel.text = recipe.type.displayName
        savedAmountLabel.text = recipe.savedAmount == 0 ? "–" : recipe.savedAmount.toRupeeString()
        
        switch recipe.type {
        case .lazySaving:
            let alarmDetails = GeneralUtilities.getAlarmDetailsString(forAlarm: recipe.alarm!)
            keyActionLabel.text = "Alarm - \(alarmDetails)"
        }
    }
    
}
