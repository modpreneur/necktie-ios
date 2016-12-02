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
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var sectionHeaderView: UIView!
    @IBOutlet var searchBar: UISearchBar!
    
    var productArray: Array<Product> = []

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
        
        requestProducts()
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
            cell.modifiedLabel.text = productUpdated.convertDate()
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
    
    func requestProducts() {
        loadingStart()
        
        APIManager.sharedManager.request(Router.products)
            .validate()
            .responseArray(keyPath: "products") { (response: DataResponse<[Product]>) in
                switch response.result {
                case .success(let responseArray):
                    for product in responseArray {
                        self.productArray.append(product)
                    }
                    
                    log.info("Loaded \(self.productArray.count) products")
                    
                    self.loadingStop()
                    
                    self.tableView.reloadData()
                case .failure(let error):
                    log.error("Request Error: \(error.localizedDescription)")
                    
                    let alert = PopupDialog(title: "ERROR", message: "\(error.localizedDescription)", image: nil, buttonAlignment: .horizontal, transitionStyle: .bounceUp, gestureDismissal: true, completion: nil)
                    let okButton = CancelButton(title: "OK", dismissOnTap: true, action: nil)
                    let retryButton = DefaultButton(title: "Retry", action: {
                        self.requestProducts()
                    })
                    alert.addButton(okButton)
                    alert.addButton(retryButton)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
