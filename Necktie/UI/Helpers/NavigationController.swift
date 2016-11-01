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
        self.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Roboto-Regular", size: 20.0)!, NSForegroundColorAttributeName: UIColor.white]
        self.navigationBar.setBackgroundImage(imageLayerForGradientBackground(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func imageLayerForGradientBackground() -> UIImage {
        var updatedFrame = self.navigationBar.bounds
        updatedFrame.size.height += 20
        let layer = CAGradientLayer.gradientLayerForBounds(bounds: updatedFrame, colors: [UIColor().necktieGradientStart.cgColor, UIColor().necktieGradientEnd.cgColor])
        UIGraphicsBeginImageContext(layer.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

}
