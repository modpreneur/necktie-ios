//
//  SettingsViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 19/1/17.
//  Copyright © 2017 Necktie. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireObjectMapper
import DZNEmptyDataSet
import Segmentio

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    
    // MARK: - IBOutlets
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var segmentio: Segmentio!
    
    // MARK: - Properties
    
    var settings: Settings? = nil
    
    private enum Tabs: String {
        case edit = "View"
        case groups = "Groups"
        
        static var allValues = [edit.rawValue,
                                groups.rawValue]
    }
    private let tabs = Tabs.allValues
    
    private let keys = ["Currency", "VAT", "Items on page", "Date", "Time", "Date time"]
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegates
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self

        // Register no data cell
        tableView.register(UINib(nibName: "NoDataCell", bundle: nil), forCellReuseIdentifier: "noDataCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
        
        requestSettings()
        setupSegmentio()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings != nil ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentio.selectedSegmentioIndex == Tabs.edit.hashValue {
            return keys.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let setting = settings!
        
        // MARK: Tab Edit
        if segmentio.selectedSegmentioIndex == Tabs.edit.hashValue {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! SettingsCell
            
            cell.keyLabel.text = keys[indexPath.row]
            
            switch indexPath.row {
                
            // Currency
            case 0:
                if let currencyCode = setting.currency, let currencySymbol = setting.currency?.getSymbolForCurrencyCode() {
                    cell.valueLabel.text = "\(currencyCode) (\(currencySymbol))"
                }
            
            // VAT
            case 1:
                if let vat = setting.vat {
                    cell.valueLabel.text = "\(vat) %"
                }
                
            // Items on page
            case 2:
                if let itemsOnPage = setting.itemsOnPage {
                    cell.valueLabel.text = "\(itemsOnPage)"
                }
                
            // Date
            case 3:
                if let date = setting.date {
                    cell.valueLabel.text = date
                }
                
            // Date
            case 4:
                if let time = setting.time {
                    cell.valueLabel.text = time
                }
                
            // Date time
            case 5:
                if let dateTime = setting.dateTime {
                    cell.valueLabel.text = dateTime
                }
            
            default:
                cell.valueLabel.text = "---"
            }
            
            return cell
        
        // MARK: Tab Groups
        } else { //if segmentio.selectedSegmentioIndex == Tabs.groups.hashValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell", for: indexPath) as! NoDataCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if segmentio.selectedSegmentioIndex == Tabs.edit.hashValue {
            return 44
        } else {
            return self.tableView.frame.size.height - 22
        }
    }
    
    // MARK: - Request
    
    func requestSettings() {
        loadingStart()
        
        APIManager.sharedManager.request(Router.settings)
            .validate()
            .responseObject { (response: DataResponse<Settings>) in
                log.debug("Request URL: \(response.request!.url!)")
                
                switch response.result {
                case .success(let response):
                    
                    self.settings = response
                    
                    log.info("Loaded settings")
                    
                    self.loadingStop()
                    
                    self.tableView.reloadData()
                case .failure(let error):
                    log.error("Request Error: \(error.localizedDescription)")
                    
                    let okAction = UIAlertAction(title: String.Alert.ok, style: .cancel, handler: nil)
                    let retryAction = UIAlertAction(title: String.Alert.retry, style: .default) { action in
                        log.info("Retry request")
                        
                        self.requestSettings()
                    }
                    
                    UIAlertController.showAlert(controller: self, title: String.Alert.error, message: "\(error.localizedDescription)", firstAction: okAction, secondAction: retryAction)
                    
                    self.loadingStop()
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

    // MARK: - DZNEmptyDataSet
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return .nothingFound
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
