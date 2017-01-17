//
//  ProjectDetailViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 19/12/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import Segmentio

class ProjectDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - IBOutlets
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var segmentio: Segmentio!
    
    // MARK: - Properties
    
    public var project: Project? = nil
    
    private enum Tabs: String {
        case edit = "View"
        case clients = "Clients"
        case status = "Status"
        case dangerzone = "Danger Zone"
        
        static var allValues = [edit.rawValue,
                                clients.rawValue,
                                status.rawValue,
                                dangerzone.rawValue]
    }
    private let tabs = Tabs.allValues
    
    private let keys = ["Name", "Company", "Description"]
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegates
        tableView.delegate = self
        tableView.dataSource = self
        
        // Register warning cell
        tableView.register(UINib(nibName: "WarningCell", bundle: nil), forCellReuseIdentifier: "warningCell")
        
        // Register no data cell
        tableView.register(UINib(nibName: "NoDataCell", bundle: nil), forCellReuseIdentifier: "noDataCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
        
        setupSegmentio()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITableView
    
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
        let project = self.project!

        // MARK: Tab Edit
        if segmentio.selectedSegmentioIndex == Tabs.edit.hashValue {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "projectDataCell", for: indexPath) as! ProjectDataCell
            
            cell.keyLabel.text = keys[indexPath.row]
        
            switch indexPath.row {
            
            // Name
            case 0:
                if let name = project.name {
                    cell.valueLabel.text = name
                }
                
            // Company
            case 1:
                if let company = project.company {
                    if let companyName = company.businessName {
                        cell.valueLabel.text = companyName
                    }
                } else {
                    cell.valueLabel.text = "---"
                }
            
            // Company
            case 2:
                cell.valueLabel.text = ""
            
            // Notification
            case 3:
                cell.keyLabel.text = "Notification"
                
            // Public ID
            case 4:
                cell.keyLabel.text = "Public ID"
                
            // Secret
            case 5:
                cell.keyLabel.text = "Secret"
                
            // Description
            case 6:
                cell.keyLabel.text = "Description"
                
            // Grant Types
            case 7:
                cell.keyLabel.text = "Grant Types"
            
            // Redirect URIs
            case 8:
                cell.keyLabel.text = "Redirect URIs"
                
            // Default
            default:
                cell.keyLabel.text = "Default"
            }
            
            return cell
        
        // MARK: OAuth Clients
        } else if segmentio.selectedSegmentioIndex == Tabs.clients.hashValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell", for: indexPath) as! NoDataCell
            
            return cell
            
        // MARK: Tab Status
        } else if segmentio.selectedSegmentioIndex == Tabs.status.hashValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell", for: indexPath) as! NoDataCell
            
            return cell
            
        // MARK: Tab Danger Zone
        } else if segmentio.selectedSegmentioIndex == Tabs.dangerzone.hashValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "warningCell", for: indexPath) as! WarningCell
            
            cell.warningLabel.text = String.Warning.project
            
            cell.deleteButton.addTarget(self, action: #selector(deleteProject(sender:)), for: .touchUpInside)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if segmentio.selectedSegmentioIndex == Tabs.edit.hashValue {
            return 44
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
        }
    }
    
    // MARK: - Delete Product
    
    @objc private func deleteProject(sender: UIButton) {
        log.info("Delete project?")
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            log.warning("Project will be deleted")
        }
        
        UIAlertController.showAlert(controller: self, title: "Delete Project", message: "Are you sure?", firstAction: cancelAction, secondAction: deleteAction)
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
