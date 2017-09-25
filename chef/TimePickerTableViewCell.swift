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
    
    weak private var delegate: RecipeDetailsFormCellDelegate!
    private var field: RecipeDetailsFormField!
    
    @IBOutlet weak private var datePicker: UIDatePicker!
    
    func setup(delegate: RecipeDetailsFormCellDelegate, field: RecipeDetailsFormField, value: Date) {
        self.delegate = delegate
        self.field = field
        datePicker.date = value
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        delegate.valueChanged(forField: field, newValue: sender.date)
    }
    
}
