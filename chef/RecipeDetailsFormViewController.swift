//
//  RecipeDetailsFormViewController.swift
//  chef
//
//  Created by Diwakar Kamboj on 22/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit

class RecipeDetailsFormViewController: UIViewController {
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeDescriptionLabel: UILabel!
    
    @IBOutlet weak var recipeNameLabelBottomSpaceConstraint: NSLayoutConstraint!
    
    var recipe: Recipe?
    var availableRecipe: AvailableRecipe?
    
    var isCreating = false

    override func viewDidLoad() {
        super.viewDidLoad()
        isCreating = availableRecipe != nil
    }
    
    private func compressHeaderView() {
        recipeDescriptionLabel.removeFromSuperview()
        recipeNameLabelBottomSpaceConstraint.constant = 10
    }

}
