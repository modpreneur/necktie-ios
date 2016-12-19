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
    
    private enum Tabs: String {
        case edit = "View"
        case status = "Status"
        case dangerzone = "Danger Zone"
        
        static var allValues = [edit.rawValue,
                                status.rawValue,
                                dangerzone.rawValue]
    }
    private let tabs = Tabs.allValues
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegates
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
        
        setupSegmentio()
        
        //requestProducts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectDataCell", for: indexPath) as! ProjectDataCell
        
        switch indexPath.row {
        
        // Name
        case 0:
            cell.keyLabel.text = "Name"
            
        // URL
        case 1:
            cell.keyLabel.text = "URL"
        
        // Company
        case 2:
            cell.keyLabel.text = "Company"
        
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
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
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
    
    @objc private func deleteProduct(sender: UIButton) {
        log.info("Delete project?")
        
        let alert = UIAlertController(title: "Delete Project", message: "Are you sure?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            log.warning("Project will be deleted")
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
