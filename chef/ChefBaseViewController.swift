//
//  ChefBaseViewController.swift
//  chef
//
//  Created by Diwakar Kamboj on 28/10/17.
//  Copyright © 2017 Diwakar Kamboj. All rights reserved.
//

import UIKit

class ChefBaseViewController: UIViewController {
    
    private var isSystemNavBarShadowHidden = false
    private lazy var blankImage = UIImage()
    
    func hideSystemNavBarShadow(_ hide: Bool) {
        if hide != isSystemNavBarShadowHidden {
            navigationController?.navigationBar.shadowImage = hide ? blankImage : nil
            isSystemNavBarShadowHidden = hide
        }
    }
    
}
