//
//  Strings.swift
//  Necktie
//
//  Created by Ondra Kandera on 16/12/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import Foundation
import UIKit

extension String {
    static let warningProduct = NSLocalizedString("With product you remove all products billing plans, there is no going back. Please be certain.", comment: "")
    static let warningBillingPlan = NSLocalizedString("Once you delete a Billing plan, there is no going back. Please be certain.", comment: "")
    static let warningUser = NSLocalizedString("With user you remove all his accesses and invoices, there is no going back. Please be certain.", comment: "")
}

extension NSAttributedString {
    static let nothingFound = NSAttributedString(string: "Nothing found", attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont(name: "Roboto-Regular", size: 26)!])
}
