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
    
    private var realmObserverToken: NotificationToken?
    
    fileprivate var recipesToDisplay = Manager.shared.getRecipes(filter: .active)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.register(UINib(nibName: ActiveRecipeDashboardTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: ActiveRecipeDashboardTableViewCell.cellReuseIdentifier)
        recipesTableView.register(UINib(nibName: InactiveRecipeDashboardTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: InactiveRecipeDashboardTableViewCell.cellReuseIdentifier)
        setupRecipesChangeObserver()
    }
    
    @IBAction func recipesSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        let recipesSegmentedControlState = RecipesSegmentedControlState(rawValue: sender.selectedSegmentIndex)!
        
        switch recipesSegmentedControlState {
        case .active:
            recipesToDisplay = Manager.shared.getRecipes(filter: .active)
        case .inactive:
            recipesToDisplay = Manager.shared.getRecipes(filter: .inactive)
        }
        
        recipesTableView.reloadData()
    }
    
    private func setupRecipesChangeObserver() {
        realmObserverToken = recipesToDisplay.addNotificationBlock { [weak self] _ in
            self?.recipesTableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: ActiveRecipeDashboardTableViewCell.cellReuseIdentifier) as! ActiveRecipeDashboardTableViewCell
        cell.setup(withRecipe: recipesToDisplay[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeDetailsFormViewController = UIStoryboard(name: Constants.Storyboards.main, bundle: nil).instantiateViewController(withIdentifier: RecipeDetailsFormViewController.identifier) as! RecipeDetailsFormViewController
        recipeDetailsFormViewController.existingRecipe = recipesToDisplay[indexPath.row]
        navigationController?.pushViewController(recipeDetailsFormViewController, animated: true)
    }
}
