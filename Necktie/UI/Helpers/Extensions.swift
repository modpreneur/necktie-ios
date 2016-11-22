//
//  Extensions.swift
//  Necktie
//
//  Created by Ondra Kandera on 7/11/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import Foundation
import UIKit

import SnapKit

extension Double {
    func toArc() -> Double {
        return (self * 0.01) * 360.0
    }
}

extension UIViewController {
    func show(activityIndicatorView: UIActivityIndicatorView, on button: UIButton) {
        activityIndicatorView.startAnimating()
        
        // "Hide" button text
        button.titleLabel?.removeFromSuperview()
        
        button.addSubview(activityIndicatorView)
        
        // Sets activityIndicatorView to center
        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.equalTo(button.snp.centerX)
            make.centerY.equalTo(button.snp.centerY)
        }
        
        button.setNeedsDisplay()
    }
    
    func dismiss(activityIndicatorView: UIActivityIndicatorView, on button: UIButton) {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.removeFromSuperview()
        
        // "Show" button text again
        button.addSubview(button.titleLabel!)
        
        button.setNeedsDisplay()
    }
}
