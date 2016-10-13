//
//  DashboardViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 6/10/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import SideMenuController

class DashboardViewController: UIViewController, SideMenuControllerDelegate {

    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenuController?.delegate = self
        
        navigationController?.addSideMenuButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - SideMenuControllerDelegate
    
    func sideMenuControllerDidHide(_ sideMenuController: SideMenuController) {
        
    }
    
    func sideMenuControllerDidReveal(_ sideMenuController: SideMenuController) {
        
    }

}
