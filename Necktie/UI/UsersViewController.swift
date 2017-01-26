//
//  UsersViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 9/11/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireObjectMapper
import DZNEmptyDataSet
import UIScrollView_InfiniteScroll

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet var tableView: TableView!
    @IBOutlet var sectionHeaderView: UIView!
    @IBOutlet var searchBar: SearchBar!

    // MARK: - Properties
    
    var userArray: [User] = []
    
    var skipCount = 0
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegates
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
        searchBar.delegate = self
        
        requestUsers(skip: 0)
        
        // Infinite Scroll
        tableView.addInfiniteScroll { (tableView) in
            self.requestUsers(skip: self.skipCount)
            
            tableView .finishInfiniteScroll()
        }
        tableView.infiniteScrollTriggerOffset = 500
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return userArray.count > 0 ? 1 : 0;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        
        let user = userArray[indexPath.row]
        
        if let userId = user.id {
            cell.idLabel.text = "\(userId)"
        }
        
        if let firstName = user.firstName, let lastName = user.lastName {
            cell.nameLabel.text = "\(firstName) \(lastName)"
        }
        
        if let email = user.email {
            cell.emailLabel.text = email
        }
        
        if let isPublic = user.isPublic {
            cell.statusLabel.text = isPublic ? "Enabled" : "Disabled"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! UserCell
        
        let user = userArray[indexPath.row]
        
        if let isPublic = user.isPublic {
            cell.statusLabel.backgroundColor = isPublic ? UIColor.necktiePrimary : UIColor.lightGray
        }
        
        cell.statusLabel.roundCorners(radius: 3)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    // MARK: - UISearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("\(searchText)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Clicked")
    }
    
    // MARK: - Request
    
    func requestUsers(skip: Int) {
        skipCount > 0 ? refreshStart() : loadingStart()
        
        APIManager.sharedManager.request(Router.users(limit: Constant.resultLimit, skip: skipCount))
            .validate()
            .responseArray(keyPath: "users") { (response: DataResponse<[User]>) in
                log.debug("Request URL: \(response.request!.url!)")
                
                switch response.result {
                case .success(let responseArray):
                    
                    // Add new objects to array
                    for user in responseArray {
                        self.userArray.append(user)
                    }
                    
                    // Set skip count
                    self.skipCount = self.skipCount + Constant.resultLimit
                    
                    log.info("Displaying \(self.userArray.count) users")
                    
                    self.refreshStop()
                    self.loadingStop()
                    
                    self.tableView.reloadData()
                case .failure(let error):
                    log.error("Request Error: \(error.localizedDescription)")
                    
                    let okAction = UIAlertAction(title: String.Alert.ok, style: .cancel, handler: nil)
                    let retryAction = UIAlertAction(title: String.Alert.retry, style: .default) { action in
                        log.info("Retry request")
                        
                        self.requestUsers(skip: 0)
                    }
                    
                    UIAlertController.showAlert(controller: self, title: String.Alert.error, message: "\(error.localizedDescription)", firstAction: okAction, secondAction: retryAction)
                    
                    self.refreshStop()
                    self.loadingStop()
                }
        }
    }
    
    // MARK: - DZNEmptyDataSet
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return .nothingFound
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.usersToUserDetail {
            let selectedCell = sender as! UITableViewCell
            let destination = segue.destination as! UsersEditViewController
            let user = userArray[(tableView.indexPath(for: selectedCell)?.row)!]
            destination.user = user
            log.info("Displaying user detail of \(user.username!)")
        }
    }

}
