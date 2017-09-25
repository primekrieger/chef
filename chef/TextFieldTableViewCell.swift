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
    
    weak var delegate: RecipeDetailsFormCellDelegate!
    var field: RecipeDetailsFormField!
    var value: String!

    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.text = value
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        delegate.valueChanged(forField: field, newValue: sender.text!)
    }
    
    
}
