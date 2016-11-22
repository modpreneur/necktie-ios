//
//  SearchBar.swift
//  Necktie
//
//  Created by Ondra Kandera on 21/11/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

class SearchBar: UISearchBar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        for subView in self.subviews  {
            for subsubView in subView.subviews  {
                if let textField = subsubView as? UITextField {
                    textField.font = UIFont(name: "Roboto-Regular", size: 14)
                }
            }
        }
    }

}
