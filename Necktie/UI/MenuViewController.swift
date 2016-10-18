//
//  MenuViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 7/10/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    
    var selectedIndex: IndexPath = IndexPath(row: 0, section: 0)

    private var previousIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.backgroundColor = UIColor().necktieSecondary
        
        // Add stretchable header view
        self.tableView.tableHeaderView = HeaderView.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 64));
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
        
        // Cell selected background
        let backgroundColorView = UIView()
        backgroundColorView.backgroundColor = UIColor().necktieSecondaryLight
        cell.selectedBackgroundView = backgroundColorView
        
        let item = menuItems[indexPath.row] as MenuItem

        // Item text converted to uppercase
        cell.menuItemName?.text = item.name.uppercased()
        
        // Change cell background color if item is selected
        cell.backgroundColor = selectedIndex == indexPath ? UIColor().necktieSecondaryLight : UIColor().necktieSecondary

        return cell
    }
    
    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let index = previousIndex {
            tableView.deselectRow(at: index, animated: true)
        }
        
        selectedIndex = indexPath
        
        let item = menuItems[indexPath.row] as MenuItem
        
        // Load desired viewController from menu
        sideMenuController?.performSegue(withIdentifier: item.segue, sender: nil)
        previousIndex = indexPath
        
        tableView.reloadData()
    }
    
    // MARK: - Scroll view delegate
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = self.tableView.tableHeaderView as! HeaderView
        headerView.scrollViewDidScroll(scrollView: scrollView)
    }

}
