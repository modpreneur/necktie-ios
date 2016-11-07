//
//  DashboardViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 6/10/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import KDCircularProgress
import RevealingSplashView
import ScrollableGraphView
import SideMenuController
import SwiftyUserDefaults
import SwiftChart

class DashboardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, SideMenuControllerDelegate {

    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegates for sideMenuController and collectionView
        sideMenuController?.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        /// Add menu button and title image to navigationBar
        navigationController?.addSideMenuButton()
        navigationController?.addTitleImage()
        
        //FIXME: Temporary
        let logout = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(logoutAction))
        navigationItem.rightBarButtonItem = logout
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Add intro animation
        if Defaults[.introAnimation] == false {
            let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "Logo_Mask")!, iconInitialSize: CGSize(width: 120, height: 125), backgroundColor: UIColor().necktiePrimary)
            let window = UIApplication.shared.keyWindow
            window?.addSubview(revealingSplashView)
            revealingSplashView.startAnimation() { }
            Defaults[.introAnimation] = true
        }
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardGraphCell", for: indexPath) as! DashboardGraphCell
            
            cell.graphView.set(data: [1, 3, 9, 8, 2, 4, 7, 2], withLabels: [])
            cell.secondGraphView.set(data: [4, 1, 2, 1, 3, 4, 1, 4], withLabels: [])
            
            cell.descriptionLabel.text = "Users activity"
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardProgressCell", for: indexPath) as! DashboardProgressCell
            
            cell.firstGraph.animate(fromAngle: 0, toAngle: 265, duration: 0.5, completion: nil)
            cell.secondGraph.animate(fromAngle: 0, toAngle: 90, duration: 0.5, completion: nil)
            
            cell.descriptionLabel.text = "Graph design 2"
            
            cell.firstGraphLabel.text = "89%"
            cell.firstGraphDescription.text = "Graph 1"
            
            cell.secondGraphLabel.text = "25%"
            cell.secondGraphDescription.text = "Graph 2"
            
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardBarGraphCell", for: indexPath) as! DashboardBarGraphCell
            
            cell.graphView.set(data: [1, 3, 9, 8, 2, 4, 7, 2], withLabels: ["1", "2", "3", "4", "5", "6", "7", "8"])
            
            cell.descriptionLabel.text = "Graph design 3"
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardProgressCell", for: indexPath) as! DashboardProgressCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let screenSize = UIApplication.shared.keyWindow?.bounds
        let insets: CGFloat = 8
        
        let width: CGFloat = (screenSize?.width)!-(2*insets)
        
        switch indexPath.row {
        case 0:
            return CGSize(width: width, height: 294)
        case 1:
            return CGSize(width: width, height: 228)
        default:
            return CGSize(width: width, height: 200)
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
