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
        self.tableView.backgroundColor = UIColor().necktieBlue
        
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
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor().necktieLightBlue
        cell.selectedBackgroundView = bgColorView
        
        let item = menuItems[indexPath.row] as MenuItem

        cell.menuItemName?.text = item.name.uppercased()
        
        if selectedIndex == indexPath {
            cell.backgroundColor = UIColor().necktieLightBlue
        } else {
            cell.backgroundColor = UIColor().necktieBlue
        }

        return cell
    }
    
    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let index = previousIndex {
            tableView.deselectRow(at: index, animated: true)
        }
        
        selectedIndex = indexPath
        
        let item = menuItems[indexPath.row] as MenuItem
        
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
