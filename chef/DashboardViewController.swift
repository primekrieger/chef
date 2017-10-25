//
//  DashboardViewController.swift
//  chef
//
//  Created by Diwakar Kamboj on 21/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit
import RealmSwift

class DashboardViewController: UIViewController {
    
    enum RecipesSegmentedControlState: Int {
        case active, inactive
    }
    
    @IBOutlet weak var recipesTableView: UITableView!
    @IBOutlet weak var noRecipesLabel: UILabel!
    
    private var realmObserverToken: NotificationToken?
    
    fileprivate var recipesToDisplay = Manager.shared.getRecipes(filter: .active)
    fileprivate var recipeStateToDisplay = RecipesSegmentedControlState.active
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.register(UINib(nibName: ActiveRecipeDashboardTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: ActiveRecipeDashboardTableViewCell.cellReuseIdentifier)
        recipesTableView.register(UINib(nibName: InactiveRecipeDashboardTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: InactiveRecipeDashboardTableViewCell.cellReuseIdentifier)
        setupRecipesChangeObserver()
        updateUI()
    }
    
    @IBAction func recipesSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        recipeStateToDisplay = RecipesSegmentedControlState(rawValue: sender.selectedSegmentIndex)!
        switch recipeStateToDisplay {
        case .active:
            recipesToDisplay = Manager.shared.getRecipes(filter: .active)
        case .inactive:
            recipesToDisplay = Manager.shared.getRecipes(filter: .inactive)
        }
        updateUI()
    }
    
    private func setupRecipesChangeObserver() {
        realmObserverToken = recipesToDisplay.addNotificationBlock { [weak self] _ in
            self?.updateUI()
        }
    }
    
    private func updateUI() {
        if recipesToDisplay.count == 0 {
            recipesTableView.isHidden = true
            switch recipeStateToDisplay {
            case .active:
                noRecipesLabel.text = Constants.Strings.noActiveRecipesLabel
            case .inactive:
                noRecipesLabel.text = Constants.Strings.noInactiveRecipesLabel
            }
        } else {
            recipesTableView.isHidden = false
            recipesTableView.reloadData()
        }
    }
    
    deinit {
        realmObserverToken?.stop()
    }

}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch recipeStateToDisplay {
        case .active:
            let cell = tableView.dequeueReusableCell(withIdentifier: ActiveRecipeDashboardTableViewCell.cellReuseIdentifier) as! ActiveRecipeDashboardTableViewCell
            cell.setup(withRecipe: recipesToDisplay[indexPath.row])
            return cell
        case .inactive:
            let cell = tableView.dequeueReusableCell(withIdentifier: InactiveRecipeDashboardTableViewCell.cellReuseIdentifier) as! InactiveRecipeDashboardTableViewCell
            cell.setup(withRecipe: recipesToDisplay[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeDetailsFormViewController = UIStoryboard(name: Constants.Storyboards.main, bundle: nil).instantiateViewController(withIdentifier: RecipeDetailsFormViewController.identifier) as! RecipeDetailsFormViewController
        recipeDetailsFormViewController.existingRecipe = recipesToDisplay[indexPath.row]
        navigationController?.pushViewController(recipeDetailsFormViewController, animated: true)
    }
}
