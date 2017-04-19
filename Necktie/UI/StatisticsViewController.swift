//
//  StatisticsViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 23/1/17.
//  Copyright © 2017 Necktie. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireObjectMapper
import ScrollableGraphView

class StatisticsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var selectedReportLabel: UILabel!
    @IBOutlet var selectedPeriodQuantityLabel: UILabel!
    @IBOutlet var graph: ScrollableGraphView!
    @IBOutlet var noDataLabel: UILabel!
    
    @IBOutlet var reportsDropdown: HADropDown!
    @IBOutlet var periodsDropdown: HADropDown!
    @IBOutlet var quantitiesDropdown: HADropDown!
    
    // MARK: - Properties
    
    let reports = ["Count of user logins",
                   "Payments by products breakdown",
                   "Payments by payment system breakdown",
                   "Income Report - payments minus refunds",
                   "Payments by billing plan breakdown",
                   "Payments by payment system vendor breakdown",
                   "Payments by New vs Existing members",
                   "Retention rate"]
    
    let periods = ["This week",
                   "Last week",
                   "This month",
                   "Last month",
                   "This year"]
    
    let quantities = ["Day",
                      "Week",
                      "Month"]
    
    var selectedReport = 0
    var selectedPeriod = 0
    var selectedQuantity = 0
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reportsDropdown.title = reports.first!
        if let selectedPeriodText = periods.first, let selectedQuantityText = quantities.first {
            selectedPeriodQuantityLabel.text = "\(selectedPeriodText) (\(selectedQuantityText.lowercased()))"
        }
        
        // Set DropDown data
        reportsDropdown.items = reports
        //periodsDropdown.items = periods
        //quantitiesDropdown.items = quantities
        
        // Set DropDown tags
        reportsDropdown.tag = 1
        //periodsDropdown.tag = 2
        //quantitiesDropdown.tag = 3
        
        // Set DropDown delegates
        reportsDropdown.delegate = self
        
        //graph.set(data: [1, 3, 9, 8, 2, 4, 7, 2], withLabels: ["1", "2", "3", "4", "5", "6", "7", "8"])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        requestGraphData(id: 1, period: .thisYear, quantity: .day)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Request
    
    func requestGraphData(id: Int, period: Period, quantity: Quantity) {
        loadingStart()
        
        APIManager.sharedManager.request(Router.statistics(id: selectedReport+1, limit: Constant.resultLimit, period: period, quantity: quantity))
            .validate()
            .responseObject(keyPath: "data") { (response: DataResponse<GraphData>) in
                log.debug("Request URL: \(response.request!.url!)")
                
                switch response.result {
                case .success(let response):
                    log.info("Downloaded graph data")
                    
                    self.setGraphData(response)
                    
                    self.loadingStop()
                    
                case .failure(let error):
                    log.error("Request Error: \(error.localizedDescription)")
                    
                    let okAction = UIAlertAction(title: String.Alert.ok, style: .cancel, handler: nil)
                    let retryAction = UIAlertAction(title: String.Alert.retry, style: .default) { action in
                        log.info("Retry request")
                        
                        
                    }
                    
                    UIAlertController.showAlert(controller: self, title: String.Alert.error, message: "\(error.localizedDescription)", firstAction: okAction, secondAction: retryAction)
                    
                    self.loadingStop()
                }
        }
    }
    
    // MARK: - Set graph data
    
    func setGraphData(_ graphData: GraphData) {
        if graphData.data.count > 0 {
            var timestamps: [String] = []
            var values: [Double] = []
            
            for item in graphData.data {
                values.append(Double(item[0]))
            }
            
            for axis in graphData.xAxis! {
                timestamps.append("\(axis)")
            }
            
            noDataLabel.isHidden = true
            graph.isHidden = false
            graph.set(data: values, withLabels: timestamps)
            graph.layoutSubviews()
        } else {
            noDataLabel.isHidden = false
            graph.isHidden = true
        }
    }
    
    // MARK: - Enum conversion
    
    fileprivate func getPeriod(_ period: Int) -> Period {
        switch period {
        case 0:
            return Period.thisWeek
        case 1:
            return Period.lastWeek
        case 2:
            return Period.thisMonth
        case 3:
            return Period.lastMonth
        case 4:
            return Period.thisYear
        default:
            return Period.thisYear
        }
    }

    fileprivate func getQuantity(_ quantity: Int) -> Quantity {
        switch quantity {
        case 0:
            return Quantity.day
        case 1:
            return Quantity.week
        case 2:
            return Quantity.month
        default:
            return Quantity.day
        }
    }
    
}

extension StatisticsViewController: HADropDownDelegate {
    func didSelectItem(dropDown: HADropDown, at index: Int) {
        if dropDown.tag == 1 {
            self.selectedReport = index
            log.info("Selected report: \(reports[index])")
        } else if dropDown.tag == 2 {
            self.selectedPeriod = index
            log.info("Selected period: \(periods[index])")
        } else if dropDown.tag == 3 {
            self.selectedQuantity = index
            log.info("Selected quantity: \(quantities[index])")
        }
        
        selectedPeriodQuantityLabel.text = "\(periods[selectedPeriod]) (\(quantities[selectedQuantity].lowercased()))"
        
        requestGraphData(id: selectedReport+1, period: getPeriod(self.selectedPeriod), quantity: getQuantity(self.selectedQuantity))
    }
}
