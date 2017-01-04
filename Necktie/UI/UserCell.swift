//
//  UserCell.swift
//  Necktie
//
//  Created by Ondra Kandera on 9/11/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
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

class UserPhotoCell: UITableViewCell {
    
    @IBOutlet var userPhoto: UIImageView!
    @IBOutlet var selectPhotoButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectPhotoButton.layer.borderWidth = 1
        self.selectPhotoButton.layer.borderColor = UIColor().necktiePrimary.cgColor
        self.selectPhotoButton.layer.cornerRadius = 3
    }
}

class UserDataCell: UITableViewCell {
    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
