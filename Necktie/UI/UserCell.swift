//
//  UserCell.swift
//  Necktie
//
//  Created by Ondra Kandera on 9/11/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

class UserCell: TableViewCell {
    
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        let color = self.statusLabel.backgroundColor
        super.setSelected(selected, animated: animated)
        self.statusLabel.backgroundColor = color
    }
}

class UserPhotoCell: TableViewCell {
    
    @IBOutlet var userPhoto: UIImageView!
    @IBOutlet var selectPhotoButton: UIButton!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectPhotoButton.addBorder(color: UIColor.necktiePrimary, width: 1, radius: 3)
    }
}

class UserDataCell: TableViewCell {
    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
