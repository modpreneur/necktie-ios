//
//  Extensions.swift
//  Necktie
//
//  Created by Ondra Kandera on 7/11/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import Foundation
import UIKit

import ARSLineProgress
import BusyNavigationBar
import SnapKit
import SwiftyBeaver

// MARK: - Double
extension Double {
    func toArc() -> Double {
        return (self * 0.01) * 360.0
    }
}

// MARK: - UIViewController
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
    
    func loadingStart() {
        ARSLineProgress.show()
        self.navigationController?.navigationBar.start()
    }
    
    func loadingStop() {
        ARSLineProgress.hide()
        self.navigationController?.navigationBar.stop()
    }
}

// MARK: - String
extension String {
    func convertDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let myDate = dateFormatter.date(from: self)!
        
        dateFormatter.dateFormat = "MMM dd, YYYY hh:mm a"
        let convertedDate = dateFormatter.string(from: myDate)
        
        return convertedDate
    }
}

// MARK: - SwiftyBeaver
public extension SwiftyBeaver {
    static func setup() {
        let console = ConsoleDestination()
        
        console.format = "$DHH:mm:ss$d $L $M"
        console.levelString.verbose = "💡[VERBOSE]:"
        console.levelString.debug = "🛠[DEBUG]:"
        console.levelString.info = "💎[INFO]:"
        console.levelString.warning = "⚠️[WARNING]:"
        console.levelString.error = "🔥[ERROR]:"
        
        log.addDestination(console)
    }
}
