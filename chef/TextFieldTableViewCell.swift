//
//  TextFieldTableViewCell.swift
//  chef
//
//  Created by Diwakar Kamboj on 25/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    
    static let nibName = "TextFieldTableViewCell"
    static let cellReuseIdentifier = "textFieldTableViewCell"
    
    weak private var delegate: RecipeDetailsFormCellDelegate!
    private var field: RecipeDetailsFormField!

    @IBOutlet weak private var textField: UITextField!
    
    func setup(delegate: RecipeDetailsFormCellDelegate, field: RecipeDetailsFormField, value: String) {
        self.delegate = delegate
        self.field = field
        textField.text = value
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        delegate.valueChanged(forField: field, newValue: sender.text!)
    }
    
}
