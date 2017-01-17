//
//  ProjectsViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 19/12/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireObjectMapper

class ProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    // MARK: - IBOutlets
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var sectionHeaderView: UIView!
    @IBOutlet var searchBar: UISearchBar!
    
    // MARK: - Properties
    
    var projectsArray: [Project] = []
    
    var skipCount = 0
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegates
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
        
        requestProjects(skip: skipCount)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return projectsArray.count > 0 ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let project = projectsArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as! ProjectCell
        
        // ID
        if let id = project.id {
            cell.idLabel.text = "\(id)"
        }
        
        // Name
        if let name = project.name {
            cell.nameLabel.text = name
        }
        
        // Company Name
        if let company = project.company {
            if let companyName = company.businessName {
                cell.companyLabel.text = companyName
            }
        } else {
            cell.companyLabel.text = "---"
        }
        
        // Locked
        cell.lockedLabel.text = project.isLocked! ? "Locked" : "Unlocked"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! ProjectCell
        
        let project = projectsArray[indexPath.row]
        
        // Customize locked label
        cell.lockedLabel.backgroundColor = project.isLocked! ? UIColor.lightGray : UIColor.necktieGreen
        cell.lockedLabel.roundCorners(radius: 3)
        
        // Colorize label
        if let color = project.color {
            cell.colorLabel.textColor = UIColor(hex: color)
        } else {
            cell.colorLabel.textColor = UIColor.clear
        }
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
    
    func requestProjects(skip: Int) {
        skipCount > 0 ? refreshStart() : loadingStart()
        
        APIManager.sharedManager.request(Router.projects(limit: Constant.resultLimit, skip: skipCount))
            .validate()
            .responseArray(keyPath: "projects") { (response: DataResponse<[Project]>) in
                log.debug("Request URL: \(response.request!.url!)")
                
                switch response.result {
                case .success(let responseArray):
                    
                    // Add new objects to array
                    for project in responseArray {
                        self.projectsArray.append(project)
                    }
                    
                    // Set skip count
                    self.skipCount = self.skipCount + Constant.resultLimit
                    
                    log.info("Displaying \(self.projectsArray.count) projects")
                    
                    self.refreshStop()
                    self.loadingStop()
                    
                    self.tableView.reloadData()
                case .failure(let error):
                    log.error("Request Error: \(error.localizedDescription)")
                    
                    let okAction = UIAlertAction(title: String.Alert.ok, style: .cancel, handler: nil)
                    let retryAction = UIAlertAction(title: String.Alert.retry, style: .default) { action in
                        log.info("Retry request")
                        
                        self.requestProjects(skip: self.skipCount)
                    }
                    
                    UIAlertController.showAlert(controller: self, title: String.Alert.error, message: "\(error.localizedDescription)", firstAction: okAction, secondAction: retryAction)
                    
                    self.refreshStop()
                    self.loadingStop()
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
