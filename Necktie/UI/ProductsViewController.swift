//
//  ProductsViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 22/11/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireObjectMapper
import DZNEmptyDataSet
import PopupDialog

class ProductsViewController: ViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    
    // MARK: - IBOutlets
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var sectionHeaderView: UIView!
    @IBOutlet var searchBar: UISearchBar!
    
    // MARK: - Properties
    
    var productArray: [Product] = []
    
    let limit = 15
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
        
        requestProducts(skip: skipCount)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell
        
        let product: Product = productArray[indexPath.row]
        
        if let productId = product.id {
            cell.idLabel.text = "\(productId)"
        }
        
        if let productName = product.name {
            cell.nameLabel.text = productName
        }
        
        if let productUpdated = product.updated {
            cell.modifiedLabel.text = productUpdated
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    // MARK: - Request
    
    func requestProducts(skip: Int) {
        loadingStart()
        
        APIManager.sharedManager.request(Router.products(limit: self.limit, skip: skipCount, sort: "id", direction: Sort.asc))
            .validate()
            .responseArray(keyPath: "products") { (response: DataResponse<[Product]>) in
                log.info("Request URL: \(response.request?.url!)")
                
                switch response.result {
                case .success(let responseArray):
                    self.productArray = []
                    
                    for product in responseArray {
                        self.productArray.append(product)
                    }
                    
                    log.info("Loaded \(self.productArray.count) products")
                    
                    self.loadingStop()
                    
                    self.tableView.reloadData()
                case .failure(let error):
                    log.error("Request Error: \(error.localizedDescription)")
                    
                    let alert = UIAlertController(title: "ERROR", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    let retryAction = UIAlertAction(title: "Retry", style: .default) { action in
                        log.info("Retry request")
                        
                        self.requestProducts(skip: self.skipCount)
                    }
                    alert.addAction(okAction)
                    alert.addAction(retryAction)
                    self.present(alert, animated: true, completion: nil)
                    
                    self.loadingStop()
                }
        }
    }
    
    // MARK: - DZNEmptyDataSet
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let emptyString: NSAttributedString = NSAttributedString(string: "Nothing found", attributes: [NSForegroundColorAttributeName: UIColor(red:0.37, green:0.38, blue:0.38, alpha:1.00), NSFontAttributeName: UIFont(name: "Roboto-Thin", size: 22)!])
        
        return emptyString
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "products->productDetail" {
            let selectedCell = sender as! UITableViewCell
            let destination = segue.destination as! ProductDetailViewController
            let product = productArray[(tableView.indexPath(for: selectedCell)?.row)!] 
            destination.product = product
            log.info("Displaying product detail of \(product.name!)")
        }
    }

}
