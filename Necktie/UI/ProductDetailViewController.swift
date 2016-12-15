//
//  ProductDetailViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 13/12/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import Segmentio
import PopupDialog

class ProductDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - IBOutlets
    
    @IBOutlet var tableView: TableView!
    @IBOutlet weak var segmentio: Segmentio!
    @IBOutlet var billingPlanSectionHeaderView: UIView!
    
    // MARK: - Properties
    
    private enum Tabs: String {
        case edit = "Edit"
        case billingPlans = "Billing Plans"
        case status = "Status"
        case dangerzone = "Danger Zone"
        
        static var allValues = [edit.rawValue,
                                billingPlans.rawValue,
                                status.rawValue,
                                dangerzone.rawValue]
    }
    private let tabs = Tabs.allValues
    
    var product: Product? = nil

    // MARK: - View controller
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = product!.name
        
        // Set tableView delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
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
            return 1
        } else if segmentio.selectedSegmentioIndex == Tabs.billingPlans.hashValue {
            let product = self.product!
            
            return product.billingPlans.count
        } else if segmentio.selectedSegmentioIndex == Tabs.dangerzone.hashValue {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = self.product!
        
        // Tab Edit
        if segmentio.selectedSegmentioIndex == Tabs.edit.hashValue {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "productDataCell", for: indexPath) as! ProductDataCell
                
                cell.keyLabel.text = "Name"
                
                if let productName = product.name {
                    cell.valueLabel.text = productName
                }
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "userDataCell", for: indexPath) as! UserDataCell
                
                return cell
            }
            
        // Tab Billing Plans
        } else if segmentio.selectedSegmentioIndex == Tabs.billingPlans.hashValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "productBillingPlanCell", for: indexPath) as! ProductBillingPlanCell
            
            let billingPlan = product.billingPlans[indexPath.row] as BillingPlan
            let paySystemVendor = billingPlan.paySystemVendor! as PaySystemVendor
            let paySystem = paySystemVendor.paySystem! as PaySystem
            
            // Label: ID
            if let billingPlanId = billingPlan.id {
                cell.idLabel.text = "\(billingPlanId)"
            }
            
            // Label: Vendor
            if let vendorName = paySystemVendor.name, let paySystemName = paySystem.name {
                cell.vendorLabel.text = "\(paySystemName): \(vendorName)"
            }
            
            // Label: Price
            if let initialPrice = billingPlan.initialPrice {
                cell.priceLabel.text = initialPrice.formatCurrency()
            }
            
            // Label: Frequency
            if let frequency = billingPlan.frequency {
                cell.frequencyLabel.text = "\(frequency)"
            } else {
                cell.frequencyLabel.text = ""
            }
            
            // Label: Trial
            if let trial = billingPlan.trial {
                cell.trialLabel.text = "\(trial)d"
            } else {
                cell.trialLabel.text = "No"
            }
            
            return cell
        
        // Tab Danger zone
        } else if segmentio.selectedSegmentioIndex == Tabs.dangerzone.hashValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "productWarningCell", for: indexPath) as! ProductWarningCell
            
            cell.selectionStyle = .none
            
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
            return 300
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if segmentio.selectedSegmentioIndex == Tabs.billingPlans.hashValue {
            return billingPlanSectionHeaderView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if segmentio.selectedSegmentioIndex == Tabs.billingPlans.hashValue {
            return 36
        } else {
            return 0
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

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productDetail->billingPlan" {
            let selectedCell = sender as! UITableViewCell
            let destination = segue.destination as! BillingPlanViewController
            let billingPlan = product?.billingPlans[(self.tableView.indexPath(for: selectedCell)?.row)!]
            destination.billingPlan = billingPlan
            log.info("Displaying billing plan \(billingPlan!.id!)")
        }
    }

}
