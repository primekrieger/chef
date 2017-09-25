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
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func weekdayButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        shouldRepeatOnDays[sender.tag] = sender.isSelected
        delegate.valueChanged(forField: field, newValue: shouldRepeatOnDays)
    }
    
}
