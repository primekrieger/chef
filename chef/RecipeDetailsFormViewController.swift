//
//  RecipeDetailsFormViewController.swift
//  chef
//
//  Created by Diwakar Kamboj on 22/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit

protocol RecipeDetailsFormCellProtocol {
    var isValueValid: Bool { get }
}

class RecipeDetailsFormViewController: UIViewController {
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeDescriptionLabel: UILabel!
    
    @IBOutlet weak var recipeNameLabelBottomSpaceConstraint: NSLayoutConstraint!
    
    var recipe: Recipe?
    var recipeTemplate: RecipeTemplate?
    
    // Remove if not really required
    var isCreating = false

    override func viewDidLoad() {
        super.viewDidLoad()
        if recipe == nil {
            isCreating = true
            recipe = Recipe()
            recipe!.templateID = recipeTemplate!.templateID
        }
    }
    
    private func compressHeaderView() {
        recipeDescriptionLabel.removeFromSuperview()
        recipeNameLabelBottomSpaceConstraint.constant = 10
    }

}

extension RecipeDetailsFormViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe!.formCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
