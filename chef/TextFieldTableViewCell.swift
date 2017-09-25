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
    var value: String!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
