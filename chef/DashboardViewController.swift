//
//  DashboardViewController.swift
//  chef
//
//  Created by Diwakar Kamboj on 21/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class DashboardViewController: ChefBaseViewController {
    
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
        askNotificationsPermission()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        recipesTableView.register(UINib(nibName: ActiveRecipeDashboardTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: ActiveRecipeDashboardTableViewCell.cellReuseIdentifier)
        recipesTableView.register(UINib(nibName: InactiveRecipeDashboardTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: InactiveRecipeDashboardTableViewCell.cellReuseIdentifier)
        recipesTableView.tableFooterView = UIView()
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
    
    private func askNotificationsPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if !granted {
                self.displayPermissionAlert()
            }
        }
    }
    
    private func displayPermissionAlert() {
        let alert = UIAlertController(title: Constants.Strings.AlertMessages.notificationsPermissionTitle, message: Constants.Strings.AlertMessages.notificationsPermissionMessage, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: Constants.Strings.AlertMessages.settingsAction, style: .default, handler: { _ in
            guard let settingsURL = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL)
            }
        })
        alert.addAction(settingsAction)
        
        let cancelAction = UIAlertAction(title: Constants.Strings.AlertMessages.cancelAction, style: .default, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func setupRecipesChangeObserver() {
        realmObserverToken = recipesToDisplay.addNotificationBlock { [weak self] _ in
            self?.updateUI()
        }
    }
    
    private func updateUI() {
        recipesTableView.isHidden = recipesToDisplay.count == 0
        if recipesTableView.isHidden {
            switch recipeStateToDisplay {
            case .active:
                noRecipesLabel.text = Constants.Strings.noActiveRecipesLabel
            case .inactive:
                noRecipesLabel.text = Constants.Strings.noInactiveRecipesLabel
            }
        } else {
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
