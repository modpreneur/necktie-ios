//
//  CompaniesViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 19/12/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireObjectMapper
import DZNEmptyDataSet

class CompaniesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {

    // MARK: - IBOutlets
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var sectionHeaderView: UIView!
    @IBOutlet var searchBar: UISearchBar!
    
    // MARK: - Properties
    
    var companiesArray: [Company] = []
    
    var skipCount = 0
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegates
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
        
        requestCompanies(skip: skipCount)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return companiesArray.count > 0 ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let company = companiesArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "companyCell", for: indexPath) as! CompanyCell
        
        // ID
        if let id = company.id {
            cell.idLabel.text = "\(id)"
        }
        
        // Name
        if let name = company.businessName {
            cell.companyLabel.text = name
        }
        
        // Contact
        if let contact = company.contactPerson {
            cell.contactLabel.text = contact
        } else {
            cell.contactLabel.text = "---"
            cell.contactLabel.textColor = UIColor.lightGray
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    // MARK: - Request
    
    func requestCompanies(skip: Int) {
        skipCount > 0 ? refreshStart() : loadingStart()
        
        APIManager.sharedManager.request(Router.companies(limit: Constant.resultLimit, skip: self.skipCount))
            .validate()
            .responseArray(keyPath: "companies") { (response: DataResponse<[Company]>) in
                log.debug("Request URL: \(response.request!.url!)")
                
                switch response.result {
                case .success(let responseArray):
                    
                    // Add new objects to array
                    for company in responseArray {
                        self.companiesArray.append(company)
                    }
                    
                    // Set skip count
                    self.skipCount = self.skipCount + Constant.resultLimit
                    
                    log.info("Displaying \(self.companiesArray.count) companies")
                    
                    self.refreshStop()
                    self.loadingStop()
                    
                    self.tableView.reloadData()
                case .failure(let error):
                    log.error("Request Error: \(error.localizedDescription)")
                    
                    let okAction = UIAlertAction(title: String.Alert.ok, style: .cancel, handler: nil)
                    let retryAction = UIAlertAction(title: String.Alert.retry, style: .default) { action in
                        log.info("Retry request")
                        
                        self.requestCompanies(skip: self.skipCount)
                    }
                    
                    UIAlertController.showAlert(controller: self, title: String.Alert.error, message: "\(error.localizedDescription)", firstAction: okAction, secondAction: retryAction)
                    
                    self.refreshStop()
                    self.loadingStop()
                }
        }
    }
    
    // MARK: - DZNEmptyDataSet
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return .nothingFound
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.companiesToCompanyDetail {
            let selectedCell = sender as! UITableViewCell
            let destination = segue.destination as! CompanyDetailViewController
            let company = companiesArray[(tableView.indexPath(for: selectedCell)?.row)!]
            destination.company = company
            log.info("Displaying product detail of \(company.businessName!)")
        }
    }

}
