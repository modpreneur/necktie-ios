//
//  MenuViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 7/10/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireObjectMapper
import KeychainAccess
import SwiftyUserDefaults

class MenuViewController: UITableViewController {
    
    private var selectedIndex: IndexPath = IndexPath(row: 0, section: 0)
    private var previousIndex: IndexPath?
    
    private var user: User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.backgroundColor = UIColor.necktieSecondary
        
        // Add stretchable header view
        self.tableView.tableHeaderView = HeaderView.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 64));
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //requestUser()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - UITableView data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count + 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // MARK: Menu item cells
        if indexPath.row < menuItems.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell
            
            // Cell selected background
            let backgroundColorView = UIView()
            backgroundColorView.backgroundColor = UIColor.necktieSecondaryLight
            cell.selectedBackgroundView = backgroundColorView
            
            let item = menuItems[indexPath.row] as MenuItem
            
            // Item text converted to uppercase
            cell.menuItemName?.text = item.name
            
            // Item icon
            cell.menuItemIcon.image = UIImage(named: item.image)
            
            // Change cell background color and font weight if item is selected
            cell.backgroundColor = selectedIndex == indexPath ? UIColor.necktieSecondaryLight : UIColor.necktieSecondary
            cell.menuItemName.font = selectedIndex == indexPath ? UIFont.robotoBold(12) : UIFont.roboto(12)
            
            return cell
            
        // MARK: Spacer cell
        } else if indexPath.row == menuItems.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "spacerCell", for: indexPath)
            
            cell.backgroundColor = UIColor.necktieSecondary
            cell.isUserInteractionEnabled = false
            
            return cell
            
        // MARK: Cell with profile image and name
        } else if indexPath.row == menuItems.count + 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! MenuProfileCell
            
            // Cell selected background
            let backgroundColorView = UIView()
            backgroundColorView.backgroundColor = UIColor.necktieSecondaryLight
            cell.selectedBackgroundView = backgroundColorView
            
            // Change cell background color and font weight if item is selected
            cell.backgroundColor = selectedIndex == indexPath ? UIColor.necktieSecondaryLight : UIColor.necktieSecondary
            
            cell.profileName.text = Defaults[.username]
            
            return cell
            
        // MARK: Cell for log out
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "logoutCell", for: indexPath) as! MenuLogoutCell
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == menuItems.count {
            let menuHeight = 64 + (menuItems.count * 40) + (48 * 2)
            let cellHeight: CGFloat = self.view.bounds.height - CGFloat(menuHeight)
            
            return cellHeight
        } else {
            return 40
        }
    }
    
    // MARK: - UITableView delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let index = previousIndex {
            tableView.deselectRow(at: index, animated: true)
        }
        
        // MARK: Empty cell
        if indexPath.row == menuItems.count {
        
        // MARK: Profile cell
        } else if indexPath.row == menuItems.count + 1 {
            selectedIndex = indexPath
            
            log.info("Open profile")
            
            let userDetailController = UIStoryboard(name: "Users", bundle: Bundle.main).instantiateViewController(withIdentifier: Controller.userDetail) as! UsersEditViewController
            let navigationController = NavigationController.init(rootViewController: userDetailController)
            userDetailController.user = self.user
            navigationController.title = "User"
            
            sideMenuController?.embed(centerViewController: navigationController)
            
            previousIndex = indexPath
            
            tableView.reloadData()
            
        // MARK: Logout cell
        } else if indexPath.row == menuItems.count + 2 {
            logoutAction()
            
        // MARK: Menu cells
        } else {
            selectedIndex = indexPath
            
            let item = menuItems[indexPath.row] as MenuItem
            
            // Load desired viewController from menu
            sideMenuController?.performSegue(withIdentifier: item.segue, sender: nil)
            previousIndex = indexPath
            
            tableView.reloadData()
        }
    }
    
    // MARK: - Scroll view delegate
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = self.tableView.tableHeaderView as! HeaderView
        headerView.scrollViewDidScroll(scrollView: scrollView)
    }
    
    // MARK: - Log Out Action
    
    private func logoutAction() {
        Defaults[.isLoggedIn] = false
        
        let keychain = Keychain(service: Constant.App.bundleId)
        keychain["access_token"] = nil
        keychain["refresh_token"] = nil
        
        let viewController: UIViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: Controller.login) as! LoginViewController
        self.present(viewController, animated: true, completion: nil)
    }

    // MARK: - Request
    
    func requestUser() {
        APIManager.sharedManager.request(Router.user(id: 0))
            .validate()
            .responseObject(keyPath: "user") { (response: DataResponse<User>) in
                
                switch response.result {
                case .success(let response):
                    
                    self.user = response
                    
                    log.info("Loaded current user from menu")
                    
                case .failure(let error):
                    log.error("Request Error: \(error.localizedDescription)")
                }
        }
    }
    
}
