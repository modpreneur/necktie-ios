//
//  DashboardCell.swift
//  Necktie
//
//  Created by Ondra Kandera on 17/10/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import KDCircularProgress
import ScrollableGraphView

class DashboardProgressCell: UICollectionViewCell {
    
    @IBOutlet var descriptionLabel: UILabel!

    @IBOutlet var firstGraph: KDCircularProgress!
    @IBOutlet var secondGraph: KDCircularProgress!

    @IBOutlet var firstGraphLabel: UILabel!
    @IBOutlet var secondGraphLabel: UILabel!
    
    @IBOutlet var firstGraphDescription: UILabel!
    @IBOutlet var secondGraphDescription: UILabel!
}

class DashboardGraphCell: UICollectionViewCell {
    
    @IBOutlet var descriptionLabel: UILabel!

    @IBOutlet var graphView: ScrollableGraphView!
    @IBOutlet var secondGraphView: ScrollableGraphView!
    
}

class DashboardBarGraphCell: UICollectionViewCell {
    
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var graphView: ScrollableGraphView!
    
}
