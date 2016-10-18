//
//  SideMenuCustom.swift
//  Necktie
//
//  Created by Ondra Kandera on 7/10/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import SideMenuController

class SideMenuCustom: SideMenuController {

    required init?(coder aDecoder: NSCoder) {
        SideMenuController.preferences.drawing.menuButtonImage = UIImage(named: "menu")
        SideMenuController.preferences.drawing.sidePanelPosition = .overCenterPanelLeft
        SideMenuController.preferences.drawing.sidePanelWidth = UIScreen.main.bounds.width * 0.75
        SideMenuController.preferences.drawing.centerPanelShadow = false
        SideMenuController.preferences.animating.statusBarBehaviour = .fadeAnimation
        SideMenuController.preferences.interaction.panningEnabled = true
        super.init(coder: aDecoder)
    }

}
