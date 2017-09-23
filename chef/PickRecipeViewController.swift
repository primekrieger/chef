//
//  PickRecipeViewController.swift
//  chef
//
//  Created by Diwakar Kamboj on 22/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit

class PickRecipeViewController: UIViewController {
    
    @IBOutlet weak var recipeTemplatesTableView: UITableView!
    
    let recipeTemplates = Manager.shared.getRecipeTemplates()

    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTemplatesTableView.register(UINib(nibName: RecipeTemplateTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: RecipeTemplateTableViewCell.cellReuseIdentifier)
    }
}

extension PickRecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeTemplates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTemplateTableViewCell.cellReuseIdentifier) as! RecipeTemplateTableViewCell
        return cell
    }
}
