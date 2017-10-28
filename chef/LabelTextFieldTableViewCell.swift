//
//  LabelTextFieldTableViewCell.swift
//  chef
//
//  Created by Diwakar Kamboj on 15/10/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit

class LabelTextFieldTableViewCell: UITableViewCell {
    
    static let nibName = "LabelTextFieldTableViewCell"
    static let cellReuseIdentifier = "labelTextFieldTableViewCell"
    
    weak private var delegate: RecipeDetailsFormCellDelegate!
    private var field: RecipeDetailsFormField!
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var textField: UITextField!
    
    lazy private var alarmTimeDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    func setup(delegate: RecipeDetailsFormCellDelegate, field: RecipeDetailsFormField, value: Any) {
        self.delegate = delegate
        self.field = field
        configureCell(value: value)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textField.delegate = self
        
        let inputToolbar = UIToolbar()
        inputToolbar.tintColor = .black
        inputToolbar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: Constants.Strings.inputToolbarDoneButtonTitle, style: UIBarButtonItemStyle.plain, target: self, action: #selector(inputToolbarDoneButtonTap))
        inputToolbar.setItems([spaceButton, doneButton], animated: false)
        textField.inputAccessoryView = inputToolbar
    }
    
    private func configureCell(value: Any) {
        switch field! {
        case .amountTextField:
            textField.text = (value as! String)
            titleLabel.text = Constants.Strings.FormCells.amountTextFieldLabel
            textField.placeholder = Constants.Strings.FormCells.amountTextFieldPlaceholder
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 12, height: 40))
            label.text = Constants.Strings.rupeeSymbol
            label.font = textField.font
            textField.leftView = label
            textField.leftViewMode = .always
            
            textField.inputView = nil
            textField.keyboardType = .numberPad
        case .alarmTimePicker:
            let alarmTime = value as! Date
            textField.text = alarmTimeDateFormatter.string(from: alarmTime)
            titleLabel.text = Constants.Strings.FormCells.alarmTimePickerLabel
            textField.placeholder = nil
            textField.leftViewMode = .never
            
            let datePicker = UIDatePicker()
            datePicker.date = alarmTime
            datePicker.datePickerMode = .time
            datePicker.backgroundColor = .white
            datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
            textField.inputView = datePicker
        default:
            break
        }
    }
    
    func inputToolbarDoneButtonTap() {
        textField.resignFirstResponder()
    }
    
    func datePickerValueChanged(_ sender: UIDatePicker) {
        let value = sender.date
        textField.text = alarmTimeDateFormatter.string(from: value)
        delegate.valueChanged(forField: field, newValue: value)
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        switch field! {
        case .amountTextField:
            delegate.valueChanged(forField: field, newValue: sender.text!)
        default:
            break
        }
    }
    
}

extension LabelTextFieldTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
