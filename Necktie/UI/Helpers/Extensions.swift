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
import Segmentio
import SnapKit
import SwiftyBeaver
import SwiftyUserDefaults

// MARK: - UIView
public extension UIView {
    /// Adds border and rounds corners
    func addBorder(color: UIColor, width: CGFloat, radius: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = radius
    }
    
    /// Rounds corners {
    func roundCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

// MARK: - UIViewController
public extension UIViewController {
    /// Adds loading indicator to button
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
    
    /// Removes loading indicator from button
    func dismiss(activityIndicatorView: UIActivityIndicatorView, on button: UIButton) {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.removeFromSuperview()
        
        // "Show" button text again
        button.addSubview(button.titleLabel!)
        
        button.setNeedsDisplay()
    }
    
    /// Starts loading animations
    func loadingStart() {
        ARSLineProgress.show()
        self.navigationController?.navigationBar.start()
    }
    
    /// Stops loading animations
    func loadingStop() {
        ARSLineProgress.hide()
        self.navigationController?.navigationBar.stop()
    }
    
    /// Starts navigationBar animation
    func refreshStart() {
        self.navigationController?.navigationBar.start()
    }
    
    /// Stops navigationBar animation
    func refreshStop() {
        self.navigationController?.navigationBar.stop()
    }
    
    /// Constructs array of SegmentioItems for Segmentio
    func setupTabs(tabs: [String]) -> [SegmentioItem] {
        var segmentioTabs: [SegmentioItem] = []
        for item in tabs {
            let tab = SegmentioItem(title: item, image: nil)
            segmentioTabs.append(tab)
        }
        return segmentioTabs
    }
}

// MARK: - UIAlertController
public extension UIAlertController {
    /// Shows UIAlertController with specified title, message and actions
    static func showAlert(controller: UIViewController, title: String, message: String, firstAction: UIAlertAction, secondAction: UIAlertAction) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        controller.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UIColor
extension UIColor {
    convenience init(hex: String) {
        let value = hex.replacingOccurrences(of: "#", with: "")
        
        let scanner = Scanner(string: value)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}

// MARK: - UIFont
public extension UIFont {
    static func robotoLight(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Light", size: size)!
    }
    
    static func roboto(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Regular", size: size)!
    }
    
    static func robotoMedium(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Medium", size: size)!
    }
    
    static func robotoBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: size)!
    }
}

// MARK: - String
public extension String {
    /// Convert date to specified format
    func convertDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let myDate = dateFormatter.date(from: self)!
        
        dateFormatter.dateFormat = "MMM dd, YYYY hh:mm a"
        let convertedDate = dateFormatter.string(from: myDate)
        
        return convertedDate
    }
    
    /// Format currency based on locale
    func formatCurrency() -> String {
        let number = Double(self)
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "en_US") // Locale.current
        currencyFormatter.currencyCode = Defaults[.currency]
        
        let priceString = currencyFormatter.string(from: NSNumber(value: number!))
        
        return priceString!
    }
    
    /// Converts country ISO code to corresponding name
    func convertCountry() -> String {
        let locale: NSLocale = NSLocale.init(localeIdentifier: "en_US")
        
        if let countryName = locale.displayName(forKey: .countryCode, value: self) {
            return countryName
        } else {
            return "Not Available"
        }
    }
}

// MARK: - Int
public extension Int {
    /// Formats given Int and returns complete String with plural if needed
    func formatDays() -> String {
        if self == 1 {
            return "\(self) day"
        } else {
            return "\(self) days"
        }
    }
}

// MARK: - Double
public extension Double {
    func toArc() -> Double {
        return (self * 0.01) * 360.0
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
