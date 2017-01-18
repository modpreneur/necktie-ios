//
//  Menu.swift
//  Necktie
//
//  Created by Ondra Kandera on 10/10/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import Foundation

/**
 Menu Item
 
 - *name* (String) = text displayed in menu
 - *segue* (String) = segue identifier to viewController (needs to be set in Menu.storyboard; probably via reference)
 - *image* (String) = name of image for icon displayed in menu next to text (in .xcassets)
 */
struct MenuItem {
    let name: String
    let segue: String
    let image: String
}

/**
 List of all items in menu (in displayed order)
 */
var menuItems: [MenuItem] = [MenuItem(name: "Dashboard",
                                           segue: "showDashboard",
                                           image: "Dashboard_vector"),
                                  MenuItem(name: "Products",
                                           segue: "showProducts",
                                           image: "Products_vector"),
                                  MenuItem(name: "Users",
                                           segue: "showUsers",
                                           image: "Users_vector"),
//                                  MenuItem(name: "Newsletters",
//                                           segue: "showDashboard",
//                                           image: "Users"),
                                  MenuItem(name: "Companies",
                                           segue: "showCompanies",
                                           image: "Companies_vector"),
                                  MenuItem(name: "Projects",
                                           segue: "showProjects",
                                           image: "Projects_vector"),
                                  MenuItem(name: "Statistics",
                                           segue: "showDashboard",
                                           image: "Users_vector"),
                                  MenuItem(name: "Settings",
                                           segue: "showDashboard",
                                           image: "Settings_vector")
]
