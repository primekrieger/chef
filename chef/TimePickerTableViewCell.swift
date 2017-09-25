//
//  TimePickerTableViewCell.swift
//  chef
//
//  Created by Diwakar Kamboj on 26/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit

class TimePickerTableViewCell: UITableViewCell {
    
    static let nibName = "TimePickerTableViewCell"
    static let cellReuseIdentifier = "timePickerTableViewCell"
    
    weak var delegate: RecipeDetailsFormCellDelegate!
    var field: RecipeDetailsFormField!
    var value: Date!
    
    @IBOutlet weak var datePicker: UIDatePicker!

    override func awakeFromNib() {
        super.awakeFromNib()
        datePicker.date = value
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        delegate.valueChanged(forField: field, newValue: sender.date)
    }
    
}
