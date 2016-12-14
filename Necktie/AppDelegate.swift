//
//  AppDelegate.swift
//  Necktie
//
//  Created by Ondra Kandera on 30/9/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import PopupDialog
import SideMenuController
import SwiftyBeaver
import SwiftyUserDefaults

let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Set up SwiftyBeaver (in Extensions.swift)
        log.setup()
        
        // Set up PopupDialog
        popupDialogConfig()
        
        log.info("Using baseURL: \(API.baseURL)")
        
        if !Defaults[.isLoggedIn] {
            
        }
        
        Defaults[.introAnimation] = false
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - PopupDialog config
    
    func popupDialogConfig() {
        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.backgroundColor      = UIColor.white
        dialogAppearance.titleFont            = UIFont(name: "Roboto-Medium", size: 18)!
        dialogAppearance.titleColor           = UIColor().necktieSecondary
        dialogAppearance.messageFont          = UIFont(name: "Roboto-Regular", size: 14)!
        dialogAppearance.messageColor         = UIColor().necktieSecondary
        
        let defaultButtonAppearance = DefaultButton.appearance()
        defaultButtonAppearance.titleFont      = UIFont(name: "Roboto-Medium", size: 16)
        defaultButtonAppearance.titleColor     = UIColor().necktiePrimary
        
        let cancelButtonAppearance = CancelButton.appearance()
        cancelButtonAppearance.titleFont      = UIFont(name: "Roboto-Regular", size: 16)
        cancelButtonAppearance.titleColor     = UIColor().necktieSecondary
        
        let destructiveButtonAppearance = DestructiveButton.appearance()
        destructiveButtonAppearance.titleFont      = UIFont(name: "Roboto-Regular", size: 16)
        destructiveButtonAppearance.titleColor     = UIColor().necktieDelete
    }

}

