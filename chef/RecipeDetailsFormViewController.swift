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
    static let identifier = "RecipeDetailsFormViewController"
    
    @IBOutlet weak private var saveButton: UIBarButtonItem!
    @IBOutlet weak private var recipeNameLabel: UILabel!
    @IBOutlet weak private var recipeDescriptionLabel: UILabel!
    @IBOutlet weak private var recipeDetailsFormTableView: UITableView!
    
    @IBOutlet weak private var deactivateRecipeView: UIView!
    
    @IBOutlet weak private var recipeNameLabelBottomSpaceConstraint: NSLayoutConstraint!
    
    var existingRecipe: Recipe?
    var recipeTemplate: RecipeTemplate?
    
    private let recipeToSave = Recipe()

    fileprivate var recipeFormModel: RecipeDetailsFormModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dismissInputViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissInputView))
        view.addGestureRecognizer(dismissInputViewTapGestureRecognizer)
        registerTableViewCells()
        configureRecipeToSave()
        recipeFormModel = (existingRecipe != nil) ? RecipeDetailsFormModel(withExistingRecipe: existingRecipe!) : RecipeDetailsFormModel(forFields: recipeToSave.formFields)
        setupUI()
    }
    
    @IBAction func saveButtonTap(_ sender: UIBarButtonItem) {
        let (validationSuccessful, errorString) = recipeFormModel.validate()
        if validationSuccessful {
            saveRecipe()
            dismissForm()
        } else {
            displayAlert(withMessage: errorString!)
        }
    }
    
    func dismissInputView() {
        view.endEditing(true)
    }
    
    private func registerTableViewCells() {
        recipeDetailsFormTableView.register(UINib(nibName: LabelTextFieldTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: LabelTextFieldTableViewCell.cellReuseIdentifier)
        recipeDetailsFormTableView.register(UINib(nibName: TimePickerTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: TimePickerTableViewCell.cellReuseIdentifier)
        recipeDetailsFormTableView.register(UINib(nibName: DayRepetitionSelectorTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: DayRepetitionSelectorTableViewCell.cellReuseIdentifier)
    }
    
    private func configureRecipeToSave() {
        if existingRecipe != nil {
            recipeToSave.uuid = existingRecipe!.uuid
            recipeToSave.templateID = existingRecipe!.templateID
            recipeToSave.savedAmount = existingRecipe!.savedAmount
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
    
    private func setupUI() {
        if existingRecipe != nil {
            if existingRecipe!.isActive {
                recipeDetailsFormTableView.tableFooterView = deactivateRecipeView
                deactivateRecipeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleRecipeActiveState)))
            } else {
                saveButton.title = Constants.Strings.activateRecipeButtonTitle
                recipeDetailsFormTableView.tableFooterView = UIView()
            }
        } else {
            recipeDetailsFormTableView.tableFooterView = UIView()
        }
    }
    
    @objc private func toggleRecipeActiveState() {
        Manager.shared.toggleRecipeActiveState(forRecipe: existingRecipe!)
        dismissForm()
    }
    
    private func compressHeaderView() {
        recipeDescriptionLabel.removeFromSuperview()
        recipeNameLabelBottomSpaceConstraint.constant = 10
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
    
    private func dismissForm() {
        if existingRecipe != nil {
            navigationController?.popToRootViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func displayAlert(withMessage message: String) {
        let alert = UIAlertController(title: Constants.Strings.AlertMessages.validationErrorTitle, message: message, preferredStyle: .alert)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelTextFieldTableViewCell.cellReuseIdentifier) as! LabelTextFieldTableViewCell
            cell.setup(delegate: self, field: field, value: recipeFormModel.amountString)
            return cell
        case .alarmTimePicker:
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelTextFieldTableViewCell.cellReuseIdentifier) as! LabelTextFieldTableViewCell
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
