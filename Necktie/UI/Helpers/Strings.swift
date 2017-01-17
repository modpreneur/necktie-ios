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
    struct Warning {
        static let product = NSLocalizedString("With product you remove all products billing plans, there is no going back. Please be certain.", comment: "")
        static let billingPlan = NSLocalizedString("Once you delete a Billing plan, there is no going back. Please be certain.", comment: "")
        static let user = NSLocalizedString("With user you remove all his accesses and invoices, there is no going back. Please be certain.", comment: "")
        static let project = NSLocalizedString("Once you delete a project, there is no going back. Please be certain.", comment: "")
    }
    
    struct Alert {
        static let error = NSLocalizedString("Error", comment: "")
        static let ok = NSLocalizedString("OK", comment: "")
        static let cancel = NSLocalizedString("Cancel", comment: "")
        static let retry = NSLocalizedString("Retry", comment: "")
        static let delete = NSLocalizedString("Delete", comment: "")
    }
}

extension NSAttributedString {
    static let nothingFound = NSAttributedString(string: NSLocalizedString("Nothing found", comment: ""), attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.roboto(26)])
}
