//
//  ProductCell.swift
//  Necktie
//
//  Created by Ondra Kandera on 22/11/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var modifiedLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

class ProductDataCell: UITableViewCell {
    
    @IBOutlet var keyLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

class ProductBillingPlanCell: UITableViewCell {
    
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var vendorLabel: UILabel!
    @IBOutlet var defaultLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var frequencyLabel: UILabel!
    @IBOutlet var trialLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class ProductWarningCell: UITableViewCell {
    
    @IBOutlet var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
