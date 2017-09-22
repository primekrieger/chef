//
//  PickRecipeViewController.swift
//  chef
//
//  Created by Diwakar Kamboj on 22/09/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit

class PickRecipeViewController: UIViewController {
    
    let availableRecipes = Manager.shared.getAvailableRecipes()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
