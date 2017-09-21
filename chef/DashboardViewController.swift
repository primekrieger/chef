//
//  DashboardViewController.swift
//  chef
//
//  Created by Diwakar Kamboj on 21/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var recipesTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.register(UINib(nibName: RecipeDashboardTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: RecipeDashboardTableViewCell.cellReuseIdentifier)
    }
    
    @IBAction func recipesSegmentedControlValueChanged(_ sender: UISegmentedControl) {
    }
    

}

extension DashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeDashboardTableViewCell.cellReuseIdentifier) as! RecipeDashboardTableViewCell
        return cell
    }
}
