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
import UIScrollView_InfiniteScroll

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
        
        requestProducts(skip: skipCount)
        
        // Infinite Scroll
        tableView.addInfiniteScroll { (tableView) in
            self.requestProducts(skip: self.skipCount)
            
            tableView .finishInfiniteScroll()
        }
        tableView.infiniteScrollTriggerOffset = 500
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return productArray.count > 0 ? 1 : 0
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
        skipCount > 0 ? refreshStart() : loadingStart()
        
        APIManager.sharedManager.request(Router.products(limit: self.limit, skip: skipCount, sort: "id", direction: Sort.asc))
            .validate()
            .responseArray(keyPath: "products") { (response: DataResponse<[Product]>) in
                log.debug("Request URL: \(response.request!.url!)")
                
                switch response.result {
                case .success(let responseArray):
                    
                    // Add new objects to array
                    for product in responseArray {
                        self.productArray.append(product)
                    }
                    
                    // Set skip count
                    self.skipCount = self.skipCount + self.limit
                    
                    log.info("Displaying \(self.productArray.count) products")
                    
                    self.refreshStop()
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
        if segue.identifier == "products->productDetail" {
            let selectedCell = sender as! UITableViewCell
            let destination = segue.destination as! ProductDetailViewController
            let product = productArray[(tableView.indexPath(for: selectedCell)?.row)!] 
            destination.product = product
            log.info("Displaying product detail of \(product.name!)")
        }
    }

}
