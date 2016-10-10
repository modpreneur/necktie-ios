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
 
 - *name* = text displayed in menu
 - *segue* = segue identifier to viewController (needs to be set in Menu.storyboard; probably via reference)
 - *image* = name of image for icon displayed in menu next to text (in .xcassets)
 */
struct MenuItem {
    let name: String
    let segue: String
    let image: String
}

/**
 List of all items in menu (in displayed order)
 */
var menuItems = [MenuItem(name: "Dashboard",
                          segue: "showDashboard",
                          image: "dashboard"),
                 MenuItem(name: "Products",
                          segue: "showDashboard",
                          image: "products"),
                 MenuItem(name: "Projects",
                          segue: "showDashboard",
                          image: "projects"),
                 MenuItem(name: "Users",
                          segue: "showDashboard",
                          image: "users")
]
