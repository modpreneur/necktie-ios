//
//  DashboardViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 6/10/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import SideMenuController
import MBCircularProgressBar

class DashboardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, SideMenuControllerDelegate {

    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenuController?.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        navigationController?.addSideMenuButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardCell", for: indexPath) as! DashboardCell
        
        switch indexPath.row {
        case 0:
            cell.progressView.maxValue = 100
            cell.progressView.showUnitString = true
            cell.progressView.setValue(75, animateWithDuration: 0.75)
            cell.descriptionLabel.text = "Active Users"
        case 1:
            cell.progressView.maxValue = 100456
            cell.progressView.showUnitString = false
            cell.progressView.setValue(100456, animateWithDuration: 0.75)
            cell.descriptionLabel.text = "Total Users"
        default:
            break
        }
        
        return cell
    }

    // MARK: - SideMenuControllerDelegate
    
    func sideMenuControllerDidHide(_ sideMenuController: SideMenuController) {
        
    }
    
    func sideMenuControllerDidReveal(_ sideMenuController: SideMenuController) {
        
    }
}
