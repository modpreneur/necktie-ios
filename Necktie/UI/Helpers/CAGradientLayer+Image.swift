//
//  CAGradientLayer+Image.swift
//  Necktie
//
//  Created by Ondra Kandera on 1/11/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

extension CAGradientLayer {
    class func gradientLayerForBounds(bounds: CGRect, colors: Array<Any>) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = bounds
        layer.colors = colors
        layer.startPoint = CGPoint.zero
        layer.endPoint = CGPoint(x: 1.0, y: 0.0)
        return layer
    }
}
