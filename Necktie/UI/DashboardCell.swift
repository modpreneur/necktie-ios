//
//  DashboardCell.swift
//  Necktie
//
//  Created by Ondra Kandera on 17/10/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import UICircularProgressRing
import SwiftChart

class DashboardProgressCell: UICollectionViewCell {
    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var progressView: UICircularProgressRingView!

}

class DashboardGraphCell: UICollectionViewCell {
    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var graphView: Chart!

}
