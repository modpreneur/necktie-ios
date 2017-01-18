//
//  CompanyCell.swift
//  Necktie
//
//  Created by Ondra Kandera on 19/12/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell {
    
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var companyLabel: UILabel!
    @IBOutlet var contactLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

class CompanyDataCell: UITableViewCell {
    
    @IBOutlet var keyLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

class CompanyLogoCell: UITableViewCell {
    
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

class CompanyProjectCell: UITableViewCell {
    
    @IBOutlet var projectName: UILabel!
    @IBOutlet var projectColorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
