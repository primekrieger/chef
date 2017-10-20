//
//  DayRepetitionSelectorTableViewCell.swift
//  chef
//
//  Created by Diwakar Kamboj on 25/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit

class DayRepetitionSelectorTableViewCell: UITableViewCell {
    
    static let nibName = "DayRepetitionSelectorTableViewCell"
    static let cellReuseIdentifier = "dayRepetitionSelectorTableViewCell"
    
    weak private var delegate: RecipeDetailsFormCellDelegate!
    private var field: RecipeDetailsFormField!
    
    @IBOutlet private var dayButtons: [UIButton]!
    
    private var shouldRepeatOnDays: [Bool]!
    
    func setup(delegate: RecipeDetailsFormCellDelegate, field: RecipeDetailsFormField, value: [Bool]) {
        self.delegate = delegate
        self.field = field
        shouldRepeatOnDays = value
        for dayButton in dayButtons {
            dayButton.isSelected = shouldRepeatOnDays[dayButton.tag]
            setSelectedStateAppearance(for: dayButton)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func setSelectedStateAppearance(for button: UIButton) {
        if button.isSelected {
            button.backgroundColor = UIColor.black
            button.layer.borderWidth = 0
        } else {
            button.backgroundColor = Constants.Colors.inactiveGray
            button.layer.borderWidth = 1
            button.layer.borderColor = Constants.Colors.borderGray.cgColor
        }
    }
    
    @IBAction func weekdayButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        setSelectedStateAppearance(for: sender)
        shouldRepeatOnDays[sender.tag] = sender.isSelected
        delegate.valueChanged(forField: field, newValue: shouldRepeatOnDays)
    }
    
}
