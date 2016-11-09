//
//  MenuContainerViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 7/10/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import SideMenuController
import SwiftyUserDefaults

class MenuContainerViewController: SideMenuCustom {

    override func viewDidLoad() {
        super.viewDidLoad()

        performSegue(withIdentifier: "showDashboard", sender: nil)
        performSegue(withIdentifier: "containSideMenu", sender: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !Defaults[.isLoggedIn] {
            let viewController: UIViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: Identifier.login) as! LoginViewController
            self.present(viewController, animated: true, completion: nil)
        }
    }

}
