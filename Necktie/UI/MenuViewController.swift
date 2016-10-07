//
//  MenuViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 7/10/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    
    struct MenuItem {
        var name: String
        var segue: String
        var image: String
    }
    
    let menuItems: Array<MenuItem> = [MenuItem.init(name: "Dashboard", segue: "showDashboard", image: "dashboard"),
                                      MenuItem.init(name: "Products", segue: "showProducts", image: "products"),
                                      MenuItem.init(name: "Projects", segue: "showProjects", image: "projects"),
                                      MenuItem.init(name: "Users", segue: "showUsers", image: "users")]

    private var previousIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell
        
        let item = menuItems[indexPath.row] as MenuItem

        cell.menuItemName?.text = item.name.uppercased()

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let index = previousIndex {
            tableView.deselectRow(at: index, animated: true)
        }
        
        let item = menuItems[indexPath.row] as MenuItem
        
        sideMenuController?.performSegue(withIdentifier: item.segue, sender: nil)
        previousIndex = indexPath
    }

}
