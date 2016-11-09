//
//  UsersViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 9/11/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set tableView delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITableView data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        
        cell.idLabel.text = "\(indexPath.row)"
        
        cell.nameLabel.text = "John Appleseed"
        
        cell.emailLabel.text = "appleseed@apple.com"
        
        cell.statusLabel.text = "Active"
        cell.statusLabel.backgroundColor = UIColor().necktiePending
        cell.statusLabel.layer.cornerRadius = 3
        cell.statusLabel.layer.masksToBounds = true
        
        return cell
    }
    
    // MARK: - UITableView delegate
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
