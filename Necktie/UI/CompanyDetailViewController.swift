//
//  CompanyDetailViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 19/12/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireObjectMapper
import AlamofireImage
import Segmentio

class CompanyDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - IBOutlets
    
    @IBOutlet var tableView: TableView!
    @IBOutlet weak var segmentio: Segmentio!
    
    // MARK: - Properties
    
    private enum Tabs: String {
        case edit = "View"
        case projects = "Projects"
        //case status = "Status"
        case dangerzone = "Danger Zone"
        
        static var allValues = [edit.rawValue,
                                projects.rawValue,
                                //status.rawValue,
                                dangerzone.rawValue]
    }
    private let tabs = Tabs.allValues
    
    let keys = ["Business Name", "Logo", "Country", "Region", "City", "ZIP or Postal Code", "Address line 1", "Address 2", "Contact Name", "Contact Email", "Support Email"]
    
    var company: Company? = nil
    
    var projectsArray: [Project] = []
    
    // MARK: - View controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = company?.businessName {
            self.title = name
        }
        
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
            return keys.count
        } else if segmentio.selectedSegmentioIndex == Tabs.projects.hashValue {
            return projectsArray.count
        } else if segmentio.selectedSegmentioIndex == Tabs.dangerzone.hashValue {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let company = self.company!
        
        // MARK: Tab Edit
        if segmentio.selectedSegmentioIndex == Tabs.edit.hashValue {
            // MARK: Logo
            if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "companyLogoCell", for: indexPath) as! CompanyLogoCell
                
                if let logoUrl = company.logo {
                    cell.activityIndicator.isHidden = false
                    cell.activityIndicator.startAnimating()
                    APIManager.sharedManager.request("https://s3-us-west-2.amazonaws.com/test-modpreneur/\(logoUrl)").responseImage(completionHandler: { response in
                        if let image = response.result.value {
                            cell.logoImageView.image = image
                        }
                        cell.activityIndicator.stopAnimating()
                    })
                }
                
                cell.selectionStyle = .none
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "companyDataCell", for: indexPath) as! CompanyDataCell
                
                cell.keyLabel.text = keys[indexPath.row]
                
                switch indexPath.row {
                
                // MARK: Business Name
                case 0:
                    if let name = company.businessName {
                        cell.valueLabel.text = name
                    } else {
                        cell.valueLabel.text = "---"
                        cell.valueLabel.textColor = UIColor.lightGray
                    }
                    
                // MARK: Country
                case 2:
                    if let country = company.country {
                        cell.valueLabel.text = country.convertCountry()
                    } else {
                        cell.valueLabel.text = "---"
                        cell.valueLabel.textColor = UIColor.lightGray
                    }
                
                // MARK: Region
                case 3:
                    if let region = company.region {
                        cell.valueLabel.text = region
                    } else {
                        cell.valueLabel.text = "---"
                        cell.valueLabel.textColor = UIColor.lightGray
                    }
                
                // MARK: City
                case 4:
                    if let city = company.city {
                        cell.valueLabel.text = city
                    } else {
                        cell.valueLabel.text = "---"
                        cell.valueLabel.textColor = UIColor.lightGray
                    }
                
                // MARK: ZIP or Postal Code
                case 5:
                    if let postalCode = company.postalCode {
                        cell.valueLabel.text = postalCode
                    } else {
                        cell.valueLabel.text = "---"
                        cell.valueLabel.textColor = UIColor.lightGray
                    }
                
                // MARK: Address 1
                case 6:
                    if let address = company.address1 {
                        cell.valueLabel.text = address
                    } else {
                        cell.valueLabel.text = "---"
                        cell.valueLabel.textColor = UIColor.lightGray
                    }
                
                // MARK: Address 2
                case 7:
                    if let address = company.address2 {
                        cell.valueLabel.text = address
                    } else {
                        cell.valueLabel.text = "---"
                        cell.valueLabel.textColor = UIColor.lightGray
                    }
                
                // MARK: Contact Person Name
                case 8:
                    if let contactPerson = company.contactPerson {
                        cell.valueLabel.text = contactPerson
                    } else {
                        cell.valueLabel.text = "---"
                        cell.valueLabel.textColor = UIColor.lightGray
                    }
                
                // MARK: Contact Person Email
                case 9:
                    if let contactPersonEmail = company.contactPersonEmail {
                        cell.valueLabel.text = contactPersonEmail
                    } else {
                        cell.valueLabel.text = "---"
                        cell.valueLabel.textColor = UIColor.lightGray
                    }
                
                // MARK: Support Email
                case 10:
                    if let supportEmail = company.supportEmail {
                        cell.valueLabel.text = supportEmail
                    } else {
                        cell.valueLabel.text = "--"
                        cell.valueLabel.textColor = UIColor.lightGray
                    }

                default:
                    cell.keyLabel.text = ""
                    cell.valueLabel.text = ""
                }
                
                cell.selectionStyle = .none
                
                return cell
            }
           
        // MARK: Tab Projects
        } else if segmentio.selectedSegmentioIndex == Tabs.projects.hashValue {
            let project = projectsArray[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "companyProjectCell", for: indexPath) as! CompanyProjectCell
            
            // Project name
            if let projectName = project.name {
                cell.projectName.text = projectName
            }
            
            // Project color
            if let color = project.color {
                cell.projectColorLabel.textColor = UIColor(hex: color)
            } else {
                cell.projectColorLabel.textColor = UIColor.clear
            }
            
            return cell
            
        // MARK: Tab Danger Zone
        } else if segmentio.selectedSegmentioIndex == Tabs.dangerzone.hashValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "warningCell", for: indexPath) as! WarningCell
            
            cell.warningLabel.text = String.Warning.product
            
            cell.deleteButton.addTarget(self, action: #selector(deleteCompany(sender:)), for: .touchUpInside)
            
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
        } else if segmentio.selectedSegmentioIndex == Tabs.projects.hashValue {
            return 44
        } else {
            if indexPath.row == 1 {
                return 80
            } else {
                return 44
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentio.selectedSegmentioIndex == Tabs.projects.hashValue {
            let vc = UIStoryboard(name: "Projects", bundle: Bundle.main).instantiateViewController(withIdentifier: Controller.projectDetail) as! ProjectDetailViewController
            let project = projectsArray[indexPath.row]
            vc.project = project
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - Segmentio
    
    fileprivate func setupSegmentio() {
        let tabs = setupTabs(tabs: self.tabs)
        SegmentioBuilder.buildSegmentioView(segmentioView: segmentio, segmentioItems: tabs, segmentioStyle: .onlyLabel)
        
        segmentio.selectedSegmentioIndex = 0
        
        segmentio.valueDidChange = { segmentio, segmentIndex in
            log.info("Selected index: \(segmentio.selectedSegmentioIndex) (\(Tabs.allValues[segmentio.selectedSegmentioIndex]))")
            
            if segmentio.selectedSegmentioIndex == Tabs.projects.hashValue {
                self.requestProjects()
            }
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Delete Product
    
    @objc private func deleteCompany(sender: UIButton) {
        log.info("Delete company?")
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            log.warning("Company will be deleted")
        }
        
        UIAlertController.showAlert(controller: self, title: "Delete Company", message: "Are you sure?", firstAction: cancelAction, secondAction: deleteAction)
    }

    // MARK: - Request
    
    func requestProjects() {
        refreshStart()
        
        guard let companyId = company?.id else {
            log.warning("No company ID")
            return
        }
        
        APIManager.sharedManager.request(Router.company(id: companyId, limit: 1000, skip: 0))
            .validate()
            .responseArray(keyPath: "projects") { (response: DataResponse<[Project]>) in
                log.debug("Request URL: \(response.request!.url!)")
                
                switch response.result {
                case .success(let responseArray):
                    
                    self.projectsArray = []
                    
                    // Add new objects to array
                    for project in responseArray {
                        self.projectsArray.append(project)
                    }
                    
                    log.info("Loaded \(self.projectsArray.count) projects")
                    
                    self.refreshStop()
                    
                    self.tableView.reloadData()
                case .failure(let error):
                    log.error("Request Error: \(error.localizedDescription)")
                    
                    let okAction = UIAlertAction(title: String.Alert.ok, style: .cancel, handler: nil)
                    let retryAction = UIAlertAction(title: String.Alert.retry, style: .default) { action in
                        log.info("Retry request")
                        
                        self.requestProjects()
                    }
                    
                    UIAlertController.showAlert(controller: self, title: String.Alert.error, message: "\(error.localizedDescription)", firstAction: okAction, secondAction: retryAction)
                    
                    self.refreshStop()
                }
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
