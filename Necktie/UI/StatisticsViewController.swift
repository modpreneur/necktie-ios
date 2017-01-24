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
import TBDropdownMenu

class StatisticsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var selectedReportLabel: UILabel!
    @IBOutlet var selectedPeriodQuantityLabel: UILabel!
    @IBOutlet var graph: ScrollableGraphView!
    @IBOutlet var noDataLabel: UILabel!
    
    // MARK: - Properties
    
    let reports = [DropdownItem(title: "Count of user logins"),
                   DropdownItem(title: "Payments by products breakdown"),
                   DropdownItem(title: "Payments by payment system breakdown"),
                   DropdownItem(title: "Income Report - payments minus refunds"),
                   DropdownItem(title: "Payments by billing plan breakdown"),
                   DropdownItem(title: "Payments by payment system vendor breakdown"),
                   DropdownItem(title: "Payments by New vs Existing members"),
                   DropdownItem(title: "Retention rate")]
    
    let periods = [DropdownItem(title: "This week"),
                   DropdownItem(title: "Last week"),
                   DropdownItem(title: "This month"),
                   DropdownItem(title: "Last month"),
                   DropdownItem(title: "This year")]
    
    let quantities = [DropdownItem(title: "Day"),
                      DropdownItem(title: "Week"),
                      DropdownItem(title: "Month")]
    
    var reportsDropdown: DropdownMenu? = nil
    var periodsDropdown: DropdownMenu? = nil
    var quantitiesDropdown: DropdownMenu? = nil
    
    var selectedReport = 0
    var selectedPeriod = 0
    var selectedQuantity = 0
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedReportLabel.text = reports.first?.title
        if let selectedPeriodText = periods.first?.title, let selectedQuantityText = quantities.first?.title {
            selectedPeriodQuantityLabel.text = "\(selectedPeriodText) (\(selectedQuantityText.lowercased()))"
        }
        
        // Add Tap gesture to label
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(reportLabelTapped))
        selectedReportLabel.isUserInteractionEnabled = true
        selectedReportLabel.addGestureRecognizer(tapGesture)
        
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
            .responseObject { (response: DataResponse<GraphData>) in
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
                timestamps.append("\(item[0].convertTimestampToDate())")
                values.append(Double(item[1]))
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
    
    // MARK: - Dropdowns
    
    @IBAction func showPeriodDropdown(sender: UIBarButtonItem) {
        periodsDropdown = DropdownMenu(navigationController: navigationController!, items: periods)
        periodsDropdown!.tag = 2
        periodsDropdown!.textFont = UIFont.roboto(12)
        periodsDropdown!.textColor = UIColor.darkGray
        periodsDropdown!.highlightColor = UIColor.necktieSecondary
        
        periodsDropdown!.delegate = self
        periodsDropdown!.displaySelected = false
        periodsDropdown!.showMenu()
    }
    
    @IBAction func showQuantityDropdown(sender: UIBarButtonItem) {
        quantitiesDropdown = DropdownMenu(navigationController: navigationController!, items: quantities)
        quantitiesDropdown!.tag = 3
        quantitiesDropdown!.textFont = UIFont.roboto(12)
        quantitiesDropdown!.textColor = UIColor.darkGray
        quantitiesDropdown!.highlightColor = UIColor.necktieSecondary
        
        quantitiesDropdown!.delegate = self
        quantitiesDropdown!.displaySelected = false
        quantitiesDropdown!.showMenu()
    }
    
    func reportLabelTapped(sender: UITapGestureRecognizer) {
        reportsDropdown = DropdownMenu(navigationController: navigationController!, items: reports)
        reportsDropdown!.tag = 1
        reportsDropdown!.textFont = UIFont.roboto(12)
        reportsDropdown!.textColor = UIColor.darkGray
        reportsDropdown!.highlightColor = UIColor.necktieSecondary
        
        reportsDropdown!.delegate = self
        reportsDropdown!.displaySelected = false
        reportsDropdown!.showMenu()
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

extension StatisticsViewController: DropdownMenuDelegate {
    func dropdownMenu(_ dropdownMenu: DropdownMenu, didSelectRowAt indexPath: IndexPath) {
        if dropdownMenu.tag == 1 {
            self.selectedReportLabel.text = reports[indexPath.row].title
            
            self.selectedReport = indexPath.row
            log.info("Selected report: \(reports[indexPath.row].title)")
        } else if dropdownMenu.tag == 2 {
            self.selectedPeriod = indexPath.row
            log.info("Selected period: \(periods[indexPath.row].title)")
        } else if dropdownMenu.tag == 3 {
             self.selectedQuantity = indexPath.row
            log.info("Selected quantity: \(quantities[indexPath.row].title)")
        }
        
        selectedPeriodQuantityLabel.text = "\(periods[selectedPeriod].title) (\(quantities[selectedQuantity].title.lowercased()))"
        
        requestGraphData(id: selectedReport+1, period: getPeriod(self.selectedPeriod), quantity: getQuantity(self.selectedQuantity))
    }
}
