//
//  DashboardViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 6/10/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import MBCircularProgressBar
import SideMenuController
import SwiftyUserDefaults
import SwiftChart

class DashboardViewController: IntroViewController, UICollectionViewDelegate, UICollectionViewDataSource, SideMenuControllerDelegate {

    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenuController?.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        navigationController?.addSideMenuButton()
        
        //FIXME: Temporary
        let logout = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(logoutAction))
        navigationItem.rightBarButtonItem = logout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardProgressCell", for: indexPath) as! DashboardProgressCell
            cell.progressView.maxValue = 100
            cell.progressView.valueIndicator = "%"
            cell.progressView.setProgress(value: 75, animationDuration: 0.75, completion: nil)
            cell.descriptionLabel.text = "Active Users"
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardProgressCell", for: indexPath) as! DashboardProgressCell
            cell.progressView.maxValue = 100456
            cell.progressView.valueIndicator = ""
            cell.progressView.setProgress(value: 100456, animationDuration: 0.75, completion: nil)
            cell.descriptionLabel.text = "Total Users"
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardGraphCell", for: indexPath) as! DashboardGraphCell
            cell.descriptionLabel.text = "Graph"
            let series = ChartSeries([0, 6.5, 2, 8, 4.1, 7, -3.1, 10, 8])
            series.color = UIColor().necktiePrimary
            cell.graphView.add(series)
            cell.graphView.topInset = 8
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardProgressCell", for: indexPath) as! DashboardProgressCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        switch indexPath.row {
        case 0, 1:
            return CGSize(width: 160, height: 200)
        case 2:
            return CGSize(width: 320, height: 180)
        default:
            return CGSize(width: 160, height: 200)
        }
    }
    
    // MARK: - Logout - Temporary
    
    func logoutAction() {
        Defaults[.isLoggedIn] = false
        let viewController: UIViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: Identifier.login) as! LoginViewController
        self.present(viewController, animated: true, completion: nil)
    }

    // MARK: - SideMenuControllerDelegate
    
    func sideMenuControllerDidHide(_ sideMenuController: SideMenuController) {
        
    }
    
    func sideMenuControllerDidReveal(_ sideMenuController: SideMenuController) {
        
    }
}
