//
//  NavigationController.swift
//  Necktie
//
//  Created by Ondra Kandera on 1/11/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = UIColor.white
        let fontDictionary = [NSForegroundColorAttributeName:UIColor.white]
        self.navigationBar.titleTextAttributes = fontDictionary
        self.navigationBar.setBackgroundImage(imageLayerForGradientBackground(), for: UIBarMetrics.default)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func imageLayerForGradientBackground() -> UIImage {
        var updatedFrame = self.navigationBar.bounds
        updatedFrame.size.height += 20
        let layer = CAGradientLayer.gradientLayerForBounds(bounds: updatedFrame, colors: [UIColor(red:0.44, green:0.41, blue:0.98, alpha:1.00).cgColor, UIColor(red:0.36, green:0.78, blue:0.93, alpha:1.00).cgColor])
        UIGraphicsBeginImageContext(layer.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

}
