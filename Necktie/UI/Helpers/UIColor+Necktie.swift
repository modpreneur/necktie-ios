//
//  UIColor+Necktie.swift
//  Necktie
//
//  Created by Ondra Kandera on 10/10/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    public var necktiePrimary: UIColor {
        return UIColor(red:0.09, green:0.741, blue:1, alpha:1)
    }
    
    public var necktieSecondary: UIColor {
        return UIColor(red:0.176, green:0.196, blue:0.243, alpha:1)
    }
    
    public var necktieSecondaryLight: UIColor {
        return UIColor(red:0.156, green:0.172, blue:0.215, alpha:1)
    }
    
    public var necktieGray: UIColor {
        return UIColor(red:0.823, green:0.843, blue:0.89, alpha:1)
    }
    
    public var necktieBackground: UIColor {
        return UIColor(red:0.858, green:0.878, blue:0.913, alpha:1)
    }
    
    public var necktieDisabled: UIColor {
        return UIColor(red:0.384, green:0.772, blue:0, alpha:1)
    }
    
    public var necktiePending: UIColor {
        return UIColor(red:0.384, green:0.772, blue:0, alpha:1)
    }
    
    public var necktieGradientStart: UIColor {
        return UIColor(red:0.36, green:0.78, blue:0.93, alpha:1.00)
    }
    
    public var necktieGradientEnd: UIColor {
        return UIColor(red:0.44, green:0.41, blue:0.98, alpha:1.00)
    }
}
