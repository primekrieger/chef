//
//  RecipeDetailsFormViewController.swift
//  chef
//
//  Created by Diwakar Kamboj on 22/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit

protocol RecipeDetailsFormCellDelegate: class {
    func valueChanged(forField field: RecipeDetailsFormField, newValue: Any)
}

class RecipeDetailsFormViewController: UIViewController {
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeDescriptionLabel: UILabel!
    @IBOutlet weak var recipeDetailsFormTableView: UITableView!
    
    @IBOutlet weak var recipeNameLabelBottomSpaceConstraint: NSLayoutConstraint!
    
    var recipe: Recipe?
    var recipeTemplate: RecipeTemplate?
    fileprivate var recipeFormModel: RecipeDetailsFormModel!
    
    // Remove if not really required
    var isCreatingNewRecipe = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeDetailsFormTableView.register(UINib(nibName: TextFieldTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: TextFieldTableViewCell.cellReuseIdentifier)
        recipeDetailsFormTableView.register(UINib(nibName: TimePickerTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: TimePickerTableViewCell.cellReuseIdentifier)
        recipeDetailsFormTableView.register(UINib(nibName: DayRepetitionSelectorTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: DayRepetitionSelectorTableViewCell.cellReuseIdentifier)
        
        if recipe == nil {
            isCreatingNewRecipe = true
            recipe = Recipe()
            recipe!.templateID = recipeTemplate!.templateID
        }
        
        recipeFormModel = isCreatingNewRecipe ? RecipeDetailsFormModel(forFields: recipe!.formFields) : RecipeDetailsFormModel(withExistingRecipe: recipe!)
    }
    
    private func compressHeaderView() {
        recipeDescriptionLabel.removeFromSuperview()
        recipeNameLabelBottomSpaceConstraint.constant = 10
    }

}

extension RecipeDetailsFormViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe!.formFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let field = recipe!.formFields[indexPath.row]
        switch field {
        case .amountTextField:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.cellReuseIdentifier) as! TextFieldTableViewCell
            cell.delegate = self
            cell.field = field
            cell.value = recipeFormModel.amount
            return cell
        case .alarmTimePicker:
            let cell = tableView.dequeueReusableCell(withIdentifier: TimePickerTableViewCell.cellReuseIdentifier) as! TimePickerTableViewCell
            cell.delegate = self
            cell.field = field
            cell.value = recipeFormModel.alarmTime
            return cell
        case .alarmRepetitionSelector:
            let cell = tableView.dequeueReusableCell(withIdentifier: DayRepetitionSelectorTableViewCell.cellReuseIdentifier) as! DayRepetitionSelectorTableViewCell
            cell.delegate = self
            cell.field = field
            cell.value = recipeFormModel.alarmRepetition
            return cell
        }
    }
}

extension RecipeDetailsFormViewController: RecipeDetailsFormCellDelegate {
    func valueChanged(forField field: RecipeDetailsFormField, newValue: Any) {
        switch field {
        case .amountTextField:
            recipeFormModel.amount = newValue as! String
        case .alarmTimePicker:
            recipeFormModel.alarmTime = newValue as! Date
        case .alarmRepetitionSelector:
            recipeFormModel.alarmRepetition = newValue as! [Bool]
        }
    }
}
