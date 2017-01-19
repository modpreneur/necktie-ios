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
import Segmentio

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var segmentio: Segmentio!
    
    // MARK: - Properties
    
    private enum Tabs: String {
        case edit = "View"
        case groups = "Groups"
        
        static var allValues = [edit.rawValue,
                                groups.rawValue]
    }
    private let tabs = Tabs.allValues
    
    var settingsArray: [String] = []
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegates
        tableView.delegate = self
        tableView.dataSource = self

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
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsArray.count > 0 ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // MARK: Tab Edit
        if segmentio.selectedSegmentioIndex == Tabs.edit.hashValue {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! SettingsCell
            
            return cell
        
        // MARK: Tab Groups
        } else { //if segmentio.selectedSegmentioIndex == Tabs.groups.hashValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell", for: indexPath) as! NoDataCell
            
            return cell
        }
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
