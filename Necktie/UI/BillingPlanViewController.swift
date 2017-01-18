//
//  BillingPlanViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 15/12/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import Segmentio

class BillingPlanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - IBOutlets
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var segmentio: Segmentio!
    
    // MARK: - Properties
    
    private enum Tabs: String {
        case edit = "View"
        case status = "Status"
        case dangerzone = "Danger Zone"
        
        static var allValues = [edit.rawValue,
                                //status.rawValue,
                                dangerzone.rawValue]
    }
    private let tabs = Tabs.allValues
    
    var billingPlan: BillingPlan? = nil
    
    // MARK: - View controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = billingPlan?.paySystemVendor?.name
        
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
    
    // MARK: - UITableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let billingPlan = self.billingPlan!
        
        if segmentio.selectedSegmentioIndex == Tabs.edit.hashValue {
            if let _ = billingPlan.frequency {
                return 8
            } else {
                return 5
            }
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _ = self.billingPlan!
        
        // Tab Edit
        if segmentio.selectedSegmentioIndex == Tabs.edit.hashValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "billingPlanCell", for: indexPath) as! BillingPlanCell
            
            self.configureEditCell(cell: cell, at: indexPath)
            
            return cell
        
        // Tab Danger Zone
        } else if segmentio.selectedSegmentioIndex == Tabs.dangerzone.hashValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "warningCell", for: indexPath) as! WarningCell
            
            cell.warningLabel.text = String.Warning.billingPlan
            
            cell.deleteButton.addTarget(self, action: #selector(deleteBillingPlan(sender:)), for: .touchUpInside)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "billingPlanCell", for: indexPath) as! BillingPlanCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if segmentio.selectedSegmentioIndex == Tabs.dangerzone.hashValue {
            let height = self.tableView.frame.size.height - 22
            return height
        } else {
            return 44
        }
    }
    
    // MARK: - Configure cells
    
    private func configureEditCell(cell: UITableViewCell, at indexPath: IndexPath) {
        let cell = cell as! BillingPlanCell
        
        let billingPlan = self.billingPlan!
        let paySystemVendor = billingPlan.paySystemVendor! as PaySystemVendor
        let paySystem = paySystemVendor.paySystem! as PaySystem
        
        var isRecurring = false
        if let _ = billingPlan.frequency {
            isRecurring = true
        }
        
        switch indexPath.row {
        case 0: // Vendor
            cell.keyLabel.text = "Vendor"
            
            if let vendorName = paySystemVendor.name, let paySystemName = paySystem.name {
                cell.valueLabel.text = "\(paySystemName): \(vendorName)"
            }
            
        case 1: // Name
            cell.keyLabel.text = paySystem.itemText()
            
            if let itemId = billingPlan.itemId {
                cell.valueLabel.text = "\(itemId)"
            }
            
        case 2: // Default
            cell.keyLabel.text = "Default"
            cell.valueLabel.text = "Yes"
            
        case 3: // Type
            cell.keyLabel.text = "Type"
            cell.valueLabel.text = isRecurring ? "Recurring" : "Standard"
            
        case 4: // Price
            cell.keyLabel.text = "Price"
            
            if let price = billingPlan.initialPrice {
                cell.valueLabel.text = price.formatCurrency()
            }
            
        case 5: // Frequency
            cell.keyLabel.text = "Frequency"
            cell.valueLabel.text = billingPlan.frequencyText()
            
        case 6: // Rebill times
            cell.keyLabel.text = "Rebill times"
            
            if let rebillTimes = billingPlan.rebillTimes {
                cell.valueLabel.text = "\(rebillTimes)"
            }
            
        case 7: // Trial period
            cell.keyLabel.text = "Trial period"
            
            if let trialPeriod = billingPlan.trial {
                cell.valueLabel.text = "\(trialPeriod)"
            }
            
        default:
            cell.keyLabel.text = ""
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
    
    // MARK: - Delete billing plan
    
    @objc private func deleteBillingPlan(sender: UIButton) {
        log.info("Delete product?")
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            log.warning("Product will be deleted")
        }
        
        UIAlertController.showAlert(controller: self, title: "Delete Billing Plan", message: "Are you sure?", firstAction: cancelAction, secondAction: deleteAction)
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
