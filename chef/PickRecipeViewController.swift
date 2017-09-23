//
//  PickRecipeViewController.swift
//  chef
//
//  Created by Diwakar Kamboj on 22/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit

class PickRecipeViewController: UIViewController {
    
    @IBOutlet weak var availableRecipesTableView: UITableView!
    
    let availableRecipes = Manager.shared.getAvailableRecipes()

    override func viewDidLoad() {
        super.viewDidLoad()
        availableRecipesTableView.register(UINib(nibName: AvailableRecipeTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: AvailableRecipeTableViewCell.cellReuseIdentifier)
    }
}

extension PickRecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AvailableRecipeTableViewCell.cellReuseIdentifier) as! AvailableRecipeTableViewCell
        return cell
    }
}
