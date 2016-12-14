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
    
    @IBOutlet var tableView: TableView!
    @IBOutlet weak var segmentio: Segmentio!
    
    struct Data {
        var key: String
        var value: String
    }
    
    let data: Array<Data> = [Data(key: "Username", value: "Tomáš Jančar"), Data(key: "E-mail", value: "tjancar@email.com"), Data(key: "Password", value: "********"), Data(key: "First name", value: "Tomáš"), Data(key: "Last name", value: "Jančar")]
    
    private enum Tabs: String {
        case edit = "Edit"
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tomáš Jančar"
        
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
        return data.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentio.selectedSegmentioIndex == Tabs.edit.hashValue {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "userPhotoCell", for: indexPath) as! UserPhotoCell
                
                cell.userPhoto.image = UIImage(named: "Avatar")
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "userDataCell", for: indexPath) as! UserDataCell
                
                let item: Data = data[indexPath.row-1]
                
                cell.descriptionLabel.text = item.key
                cell.valueLabel.text = item.value
                
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 94
        } else {
            return 50
        }
    }
    
    // MARK: - Segmentio
    
    fileprivate func setupSegmentio() {
        let tabs = setupTabs(tabs: self.tabs)
        SegmentioBuilder.buildSegmentioView(segmentioView: segmentio, segmentioItems: tabs, segmentioStyle: .onlyLabel)
        
        segmentio.selectedSegmentioIndex = 0
        
        segmentio.valueDidChange = { segmentio, segmentIndex in
            log.info("Selected index: \(segmentio.selectedSegmentioIndex)")
            
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
