//
//  CompanyDetailViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 19/12/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import Segmentio

class CompanyDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - IBOutlets
    
    @IBOutlet var tableView: TableView!
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
    
    var product: Product? = nil
    
    // MARK: - View controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Modpreneur"
        
        // Set tableView delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        
        // Register warning cell
        tableView.register(UINib(nibName: "WarningCell", bundle: nil), forCellReuseIdentifier: "warningCell")
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
            return 10
        } else if segmentio.selectedSegmentioIndex == Tabs.dangerzone.hashValue {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let product = self.product!
        
        // Tab Edit
        if segmentio.selectedSegmentioIndex == Tabs.edit.hashValue {
            if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "companyLogoCell", for: indexPath) as! CompanyLogoCell
                
                cell.imageView?.image = UIImage(named: "Login_Logo")
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "companyDataCell", for: indexPath) as! CompanyDataCell
                
                switch indexPath.row {
                
                // Business Name
                case 0:
                    cell.keyLabel.text = "Business Name"
                    
                // Country
                case 2:
                    cell.keyLabel.text = "Country"
                
                // State
                case 3:
                    cell.keyLabel.text = "Region"
                
                // City
                case 4:
                    cell.keyLabel.text = "City"
                
                // ZIP or Postal Code
                case 5:
                    cell.keyLabel.text = "ZIP or Postal City"
                
                // Address 1
                case 6:
                    cell.keyLabel.text = "Address line 1"
                
                // Address 2
                case 7:
                    cell.keyLabel.text = "Address 2"
                
                // Contact Person Name
                case 8:
                    cell.keyLabel.text = "Contact Name"
                
                // Contact Person Email
                case 9:
                    cell.keyLabel.text = "Contact Email"
                
                // Support Email
                case 10:
                    cell.keyLabel.text = "Support Email"

                default:
                    cell.keyLabel.text = "Default"
                }
                
                cell.valueLabel.text = "Test"
                
                return cell
            }
            
        // Tab Billing Plans
        } else if segmentio.selectedSegmentioIndex == Tabs.dangerzone.hashValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "warningCell", for: indexPath) as! WarningCell
            
            cell.warningLabel.text = String.Warning.product
            
            cell.deleteButton.addTarget(self, action: #selector(deleteProduct(sender:)), for: .touchUpInside)
            
            return cell
            
        // Default
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if segmentio.selectedSegmentioIndex == Tabs.dangerzone.hashValue {
            let height = self.tableView.frame.size.height - 22
            return height
        } else {
            if indexPath.row == 1 {
                return 80
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
    
    @objc private func deleteProduct(sender: UIButton) {
        log.info("Delete company?")
        
        let alert = UIAlertController(title: "Delete Company", message: "Are you sure?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            log.warning("Company will be deleted")
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
