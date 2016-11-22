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
