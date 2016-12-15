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
        case edit = "Edit"
        case status = "Status"
        case dangerzone = "Danger Zone"
        
        static var allValues = [edit.rawValue,
                                status.rawValue,
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
        //let billingPlan = self.billingPlan!
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let billingPlan = self.billingPlan!
        
        if segmentio.selectedSegmentioIndex == Tabs.edit.hashValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "billingPlanCell", for: indexPath) as! BillingPlanCell
            
            cell.keyLabel.text = "Test"
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "billingPlanCell", for: indexPath) as! BillingPlanCell
            
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
