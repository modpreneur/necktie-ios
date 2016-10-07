//
//  MenuContainerViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 7/10/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import SideMenuController

class MenuContainerViewController: SideMenuCustom {

    override func viewDidLoad() {
        super.viewDidLoad()

        performSegue(withIdentifier: "showDashboard", sender: nil)
        performSegue(withIdentifier: "containSideMenu", sender: nil)
    }

}
