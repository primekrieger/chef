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
    
    var existingRecipe: Recipe?
    var recipeTemplate: RecipeTemplate?
    
    private let recipeToSave = Recipe()

    fileprivate var recipeFormModel: RecipeDetailsFormModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
        configureRecipeToSave()
        recipeFormModel = (existingRecipe != nil) ? RecipeDetailsFormModel(withExistingRecipe: existingRecipe!) : RecipeDetailsFormModel(forFields: recipeToSave.formFields)
    }
    
    private func registerTableViewCells() {
        recipeDetailsFormTableView.register(UINib(nibName: TextFieldTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: TextFieldTableViewCell.cellReuseIdentifier)
        recipeDetailsFormTableView.register(UINib(nibName: TimePickerTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: TimePickerTableViewCell.cellReuseIdentifier)
        recipeDetailsFormTableView.register(UINib(nibName: DayRepetitionSelectorTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: DayRepetitionSelectorTableViewCell.cellReuseIdentifier)
    }
    
    private func configureRecipeToSave() {
        if existingRecipe != nil {
            recipeToSave.uuid = existingRecipe!.uuid
            recipeToSave.templateID = existingRecipe!.templateID
        } else {
            recipeToSave.templateID = recipeTemplate!.templateID
        }
        
        switch recipeToSave.type {
        case .lazySaving:
            recipeToSave.alarm = Alarm()
            if existingRecipe != nil {
                recipeToSave.alarm!.uuid = existingRecipe!.alarm!.uuid
            }
        }
    }
    
    private func compressHeaderView() {
        recipeDescriptionLabel.removeFromSuperview()
        recipeNameLabelBottomSpaceConstraint.constant = 10
    }
    
    private func saveButtonTap() {
        let (validationSuccessful, errorString) = recipeFormModel.validate()
        
        if validationSuccessful {
            saveRecipe()
        } else {
            displayAlert(withMessage: errorString!)
        }
    }
    
    private func saveRecipe() {
        for field in recipeFormModel.fields {
            switch field {
            case .amountTextField:
                recipeToSave.amount = Int(recipeFormModel.amountString)!
            case .alarmTimePicker:
                recipeToSave.alarm!.hour = Calendar.current.component(.hour, from: recipeFormModel.alarmTime)
                recipeToSave.alarm!.minute = Calendar.current.component(.minute, from: recipeFormModel.alarmTime)
            case .alarmRepetitionSelector:
                for i in 0..<recipeFormModel.shouldRepeatAlarmOnDays.count {
                    let shouldRepeatOnDay = RealmBool()
                    if existingRecipe != nil {
                        shouldRepeatOnDay.uuid = existingRecipe!.alarm!.shouldRepeatOnDays[i].uuid
                    }
                    shouldRepeatOnDay.value = recipeFormModel.shouldRepeatAlarmOnDays[i]
                    recipeToSave.alarm!.shouldRepeatOnDays.append(shouldRepeatOnDay)
                }
            }
        }
        
        Manager.shared.saveRecipe(recipeToSave)
    }
    
    private func displayAlert(withMessage message: String) {
        let alert = UIAlertController(title: Constants.Strings.AlertMessages.title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.Strings.AlertMessages.okAction, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}

extension RecipeDetailsFormViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeFormModel.fields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let field = recipeFormModel.fields[indexPath.row]
        switch field {
        case .amountTextField:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.cellReuseIdentifier) as! TextFieldTableViewCell
            cell.setup(delegate: self, field: field, value: recipeFormModel.amountString)
            return cell
        case .alarmTimePicker:
            let cell = tableView.dequeueReusableCell(withIdentifier: TimePickerTableViewCell.cellReuseIdentifier) as! TimePickerTableViewCell
            cell.setup(delegate: self, field: field, value: recipeFormModel.alarmTime)
            return cell
        case .alarmRepetitionSelector:
            let cell = tableView.dequeueReusableCell(withIdentifier: DayRepetitionSelectorTableViewCell.cellReuseIdentifier) as! DayRepetitionSelectorTableViewCell
            cell.setup(delegate: self, field: field, value: recipeFormModel.shouldRepeatAlarmOnDays)
            return cell
        }
    }
}

extension RecipeDetailsFormViewController: RecipeDetailsFormCellDelegate {
    func valueChanged(forField field: RecipeDetailsFormField, newValue: Any) {
        switch field {
        case .amountTextField:
            recipeFormModel.amountString = newValue as! String
        case .alarmTimePicker:
            recipeFormModel.alarmTime = newValue as! Date
        case .alarmRepetitionSelector:
            recipeFormModel.shouldRepeatAlarmOnDays = newValue as! [Bool]
        }
    }
}
