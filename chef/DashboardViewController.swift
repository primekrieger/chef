//
//  DashboardViewController.swift
//  chef
//
//  Created by Diwakar Kamboj on 21/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    enum RecipesSegmentedControlState: Int {
        case active, inactive
    }
    
    @IBOutlet weak var recipesTableView: UITableView!
    
    var recipesToDisplay = Manager.shared.getRecipes(filter: .active)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.register(UINib(nibName: RecipeDashboardTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: RecipeDashboardTableViewCell.cellReuseIdentifier)
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

}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeDashboardTableViewCell.cellReuseIdentifier) as! RecipeDashboardTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeDetailsFormViewController = UIStoryboard(name: Constants.Storyboards.main, bundle: nil).instantiateViewController(withIdentifier: RecipeDetailsFormViewController.identifier) as! RecipeDetailsFormViewController
        recipeDetailsFormViewController.existingRecipe = recipesToDisplay[indexPath.row]
        navigationController?.pushViewController(recipeDetailsFormViewController, animated: true)
    }
}
