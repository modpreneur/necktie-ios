//
//  GradientView.swift
//  Necktie
//
//  Created by Ondra Kandera on 21/10/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView {
    
    @IBInspectable var startColor: UIColor = UIColor.orange
    @IBInspectable var endColor: UIColor = UIColor.red
    
    /// 0 = vertical, 1 = horizontal
    @IBInspectable var orientation: Int = 0
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let colors = [startColor.cgColor, endColor.cgColor]
        
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: [0.0, 1.0])
        
        if orientation == 0 {
            let startPoint = CGPoint.zero
            let endPoint = CGPoint(x: 0, y: self.bounds.height)
            context!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
        } else {
            let startPoint = CGPoint.zero
            let endPoint = CGPoint(x: self.bounds.width, y: 0)
            context!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
        }
    }
    
}

