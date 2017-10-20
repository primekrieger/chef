//
//  RecipeTemplateTableViewCell.swift
//  chef
//
//  Created by Diwakar Kamboj on 23/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit

class RecipeTemplateTableViewCell: UITableViewCell {
    
    static let nibName = "RecipeTemplateTableViewCell"
    static let cellReuseIdentifier = "recipeTemplateTableViewCell"
    
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    
    func setup(displayName: String, shortDescription: String) {
        nameLabel.text = displayName
        descriptionLabel.text = shortDescription
    }
    
}
