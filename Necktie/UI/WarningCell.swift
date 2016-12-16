//
//  WarningCell.swift
//  Necktie
//
//  Created by Ondra Kandera on 16/12/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

class WarningCell: UITableViewCell {

    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var warningLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
    
}
