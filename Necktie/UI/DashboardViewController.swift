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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenuController?.delegate = self
        
        navigationController?.addSideMenuButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func sideMenuControllerDidHide(_ sideMenuController: SideMenuController) {
        print(#function)
    }
    
    func sideMenuControllerDidReveal(_ sideMenuController: SideMenuController) {
        print(#function)
    }

}
