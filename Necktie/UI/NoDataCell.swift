//
//  NoDataCell.swift
//  Necktie
//
//  Created by Ondra Kandera on 20/12/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

class NoDataCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
    
}
