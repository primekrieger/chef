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
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
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
