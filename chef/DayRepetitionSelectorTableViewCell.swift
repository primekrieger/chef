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
    
    weak var delegate: RecipeDetailsFormCellDelegate!
    var field: RecipeDetailsFormField!
    var value: [Bool]!
    
    @IBOutlet var dayButtons: [UIButton]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for dayButton in dayButtons {
            dayButton.isSelected = value[dayButton.tag]
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func weekdayButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        value[sender.tag] = sender.isSelected
        delegate.valueChanged(forField: field, newValue: value)
    }
    
    
}
