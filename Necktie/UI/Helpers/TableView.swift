//
//  TableView.swift
//  Necktie
//
//  Created by Ondra Kandera on 18/11/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

@IBDesignable class TableView: UITableView {
    
    var headerView: UIView! = UIView(frame: CGRect(x: 0, y: 0, width: (UIApplication.shared.keyWindow?.frame.size.width)!, height: 11))
    var footerView: UIView! = UIView(frame: CGRect(x: 0, y: 0, width: (UIApplication.shared.keyWindow?.frame.size.width)!, height: 11))
    
    @IBInspectable var headerBackgroundColor: UIColor = UIColor.white
    @IBInspectable var headerCornerRadius: CGFloat = 3
    
    @IBInspectable var footerBackgroundColor: UIColor = UIColor.white
    @IBInspectable var footerCornerRadius: CGFloat = 3
    
    @IBInspectable var scrollIndicatorInsetRight: CGFloat = -8
    
    @IBInspectable var separatorInsetLeft: CGFloat = 16
    @IBInspectable var separatorInsetRight: CGFloat = 16
    
    override func awakeFromNib() {
        // Configure
        clipsToBounds = false
        scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, scrollIndicatorInsetRight)
        separatorInset = UIEdgeInsetsMake(0, separatorInsetLeft, 0, separatorInsetRight)
        
        // Header View
        headerView.clipsToBounds = true
        headerView.backgroundColor = UIColor.clear
        
        let headerInsideView: UIView! = UIView(frame: CGRect(x: 0, y: 8, width: headerView.frame.size.width-16, height: headerView.frame.size.height))
        headerInsideView.backgroundColor = headerBackgroundColor
        headerInsideView.layer.cornerRadius = headerCornerRadius
        headerInsideView.layer.masksToBounds = true
        
        headerView.addSubview(headerInsideView)
        
        self.tableHeaderView = headerView
        
        // Footer View
        footerView.clipsToBounds = true
        footerView.backgroundColor = UIColor.clear
        
        let footerInsideView: UIView! = UIView(frame: CGRect(x: 0, y: -8, width: footerView.frame.size.width-16, height: footerView.frame.size.height))
        footerInsideView.backgroundColor = footerBackgroundColor
        footerInsideView.layer.cornerRadius = footerCornerRadius
        footerInsideView.layer.masksToBounds = true
        
        footerView.addSubview(footerInsideView)
        
        self.tableFooterView = footerView
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
