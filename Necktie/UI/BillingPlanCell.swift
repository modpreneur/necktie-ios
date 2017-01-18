//
//  BillingPlanCell.swift
//  Necktie
//
//  Created by Ondra Kandera on 15/12/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

class BillingPlanCell: TableViewCell {
    
    @IBOutlet var keyLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
