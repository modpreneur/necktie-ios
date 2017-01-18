//
//  ProjectsCell.swift
//  Necktie
//
//  Created by Ondra Kandera on 19/12/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

class ProjectCell: TableViewCell {
    
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var lockedLabel: UILabel!
    @IBOutlet var companyLabel: UILabel!
    @IBOutlet var colorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        let color = self.lockedLabel.backgroundColor
        super.setSelected(selected, animated: animated)
        self.lockedLabel.backgroundColor = color
    }

}

class ProjectDataCell: TableViewCell {
    
    @IBOutlet var keyLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var colorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
