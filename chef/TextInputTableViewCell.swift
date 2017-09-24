//
//  TextInputTableViewCell.swift
//  chef
//
//  Created by Diwakar Kamboj on 24/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit

class TextInputTableViewCell: UITableViewCell, RecipeDetailsFormCellProtocol {
    
    private(set) var isValueValid = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
