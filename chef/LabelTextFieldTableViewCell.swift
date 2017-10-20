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
    
    func setup(delegate: RecipeDetailsFormCellDelegate, field: RecipeDetailsFormField, value: String) {
        self.delegate = delegate
        self.field = field
        textField.text = value
        configureCellForField()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
    
    private func configureCellForField() {
        switch field! {
        case .amountTextField:
            titleLabel.text = Constants.Strings.FormCells.amountTextFieldLabel
            textField.placeholder = Constants.Strings.FormCells.amountTextFieldPlaceholder
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 12, height: 40))
            label.text = "₹"
            label.font = textField.font
            textField.leftView = label
            textField.leftViewMode = .always
        default:
            break
        }
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        delegate.valueChanged(forField: field, newValue: sender.text!)
    }
    
}

extension LabelTextFieldTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
