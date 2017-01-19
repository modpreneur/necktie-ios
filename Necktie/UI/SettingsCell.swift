//
//  SettingsCell.swift
//  Necktie
//
//  Created by Ondra Kandera on 19/1/17.
//  Copyright © 2017 Necktie. All rights reserved.
//

import UIKit

class SettingsCell: TableViewCell {
    
    @IBOutlet var keyLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
