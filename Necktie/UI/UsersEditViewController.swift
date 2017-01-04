//
//  UsersEditViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 11/11/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import Segmentio

class UsersEditViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - IBOutlets
    
    @IBOutlet var tableView: TableView!
    @IBOutlet weak var segmentio: Segmentio!
    
    // MARK: - Properties
    
    var user: User? = nil
    
    private enum Tabs: String {
        case edit = "View"
        case newsletter = "Newsletter"
        case invoices = "Invoices"
        case accesses = "Accesses"
        case history = "History"
        case permissions = "Permissions"
        case status = "Status"
        case dangerzone = "Danger Zone"
        
        static var allValues = [edit.rawValue,
                                newsletter.rawValue,
                                invoices.rawValue,
                                accesses.rawValue,
                                history.rawValue,
                                permissions.rawValue,
                                status.rawValue,
                                dangerzone.rawValue]
    }
    private let tabs = Tabs.allValues
    
    private let keys = ["User Picture", "Username", "Email", "First Name", "Last Name", "Phone Number", "Website", "Country"]
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let firstName = user?.firstName, let lastName = user?.lastName {
            self.title = "\(firstName) \(lastName)"
        } else {
            if let username = user?.username {
                self.title = username
            }
        }
        
        // Set tableView delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        
        // Register warning cell
        tableView.register(UINib(nibName: "WarningCell", bundle: nil), forCellReuseIdentifier: "warningCell")
        
        // Register warning cell
        tableView.register(UINib(nibName: "NoDataCell", bundle: nil), forCellReuseIdentifier: "noDataCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupSegmentio()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableView data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentio.selectedSegmentioIndex == Tabs.edit.hashValue {
            return keys.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = self.user!
        
        // MARK: Tab Edit
        if segmentio.selectedSegmentioIndex == Tabs.edit.hashValue {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "userPhotoCell", for: indexPath) as! UserPhotoCell
                
                cell.userPhoto.image = UIImage(named: "Avatar")
                
                if let firstName = user.firstName, let lastName = user.lastName {
                    cell.nameLabel.text = "\(firstName) \(lastName)"
                } else {
                    if let username = user.username {
                        cell.nameLabel.text = username
                    }
                }
                
                cell.selectionStyle = .none
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "userDataCell", for: indexPath) as! UserDataCell
                
                cell.descriptionLabel.text = keys[indexPath.row]
                
                switch indexPath.row {
                // Username
                case 1:
                    if let username = user.username {
                        cell.valueLabel.text = username
                    }
                    
                // Email
                case 2:
                    if let email = user.email {
                        cell.valueLabel.text = email
                    }
                
                // First Name
                case 3:
                    if let firstName = user.firstName {
                        cell.valueLabel.text = firstName
                    } else {
                        cell.valueLabel.text = "---"
                        cell.valueLabel.textColor = UIColor.lightGray
                    }
                
                // Last Name
                case 4:
                    if let lastName = user.lastName {
                        cell.valueLabel.text = lastName
                    } else {
                        cell.valueLabel.text = "---"
                        cell.valueLabel.textColor = UIColor.lightGray
                    }
                
                // Phone Number
                case 5:
                    if let phoneNumber = user.phoneNumber {
                        cell.valueLabel.text = phoneNumber
                    } else {
                        cell.valueLabel.text = "---"
                        cell.valueLabel.textColor = UIColor.lightGray
                    }
                
                // Website
                case 6:
                    if let website = user.website {
                        cell.valueLabel.text = website
                    } else {
                        cell.valueLabel.text = "---"
                        cell.valueLabel.textColor = UIColor.lightGray
                    }
                
                // Country
                case 7:
                    if let country = user.country {
                        cell.valueLabel.text = country.convertCountry()
                    } else {
                        cell.valueLabel.text = "---"
                        cell.valueLabel.textColor = UIColor.lightGray
                    }
                    
                default:
                    cell.descriptionLabel.text = "Key"
                    cell.valueLabel.text = "Value"
                }
                return cell
            }
            
        // MARK: Tab Newsletter
        } else if segmentio.selectedSegmentioIndex == Tabs.newsletter.hashValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell", for: indexPath) as! NoDataCell
            
            return cell
        
        // MARK: Tab Invoices
        } else if segmentio.selectedSegmentioIndex == Tabs.invoices.hashValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell", for: indexPath) as! NoDataCell
            
            return cell
        
        // MARK: Tab Accesses
        } else if segmentio.selectedSegmentioIndex == Tabs.accesses.hashValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell", for: indexPath) as! NoDataCell
            
            return cell
        
        // MARK: Tab History
        } else if segmentio.selectedSegmentioIndex == Tabs.history.hashValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell", for: indexPath) as! NoDataCell
            
            return cell
            
        // MARK: Tab Permissions
        } else if segmentio.selectedSegmentioIndex == Tabs.permissions.hashValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell", for: indexPath) as! NoDataCell
            
            return cell
        
        // MARK: Tab Status
        } else if segmentio.selectedSegmentioIndex == Tabs.status.hashValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell", for: indexPath) as! NoDataCell
            
            return cell
        
        // MARK: Tab Danger Zone
        } else if segmentio.selectedSegmentioIndex == Tabs.dangerzone.hashValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "warningCell", for: indexPath) as! WarningCell
            
            cell.warningLabel.text = .warningUser
            
            cell.deleteButton.addTarget(self, action: #selector(deleteUser(sender:)), for: .touchUpInside)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if segmentio.selectedSegmentioIndex == Tabs.edit.hashValue {
            if indexPath.row == 0 {
                return 94
            } else {
                return 50
            }
        } else {
            let array: [String] = []
            if array.count == 0 {
                return self.tableView.frame.size.height - 22
            } else {
                return 44
            }
        }
    }
    
    // MARK: - Segmentio
    
    fileprivate func setupSegmentio() {
        let tabs = setupTabs(tabs: self.tabs)
        SegmentioBuilder.buildSegmentioView(segmentioView: segmentio, segmentioItems: tabs, segmentioStyle: .onlyLabel)
        
        segmentio.selectedSegmentioIndex = 0
        
        segmentio.valueDidChange = { segmentio, segmentIndex in
            log.info("Selected index: \(segmentio.selectedSegmentioIndex) (\(Tabs.allValues[segmentio.selectedSegmentioIndex]))")
            
            self.tableView.reloadData()
            
            //TODO: Temporary fix, remove
            let collectionView: UICollectionView = segmentio.subviews[0] as! UICollectionView
            collectionView.reloadData()
        }
    }
    
    // MARK: - Delete Product
    
    @objc private func deleteUser(sender: UIButton) {
        log.info("Delete product?")
        
        let alert = UIAlertController(title: "Delete Product", message: "Are you sure?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            log.warning("Product will be deleted")
        }
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
