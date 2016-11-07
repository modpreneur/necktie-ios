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

class DashboardSummaryCell: UICollectionViewCell {
    
    @IBOutlet var firstItemImage: UIImageView!
    @IBOutlet var firstItemValue: UILabel!
    @IBOutlet var firstItemDescription: UILabel!
    @IBOutlet var firstItemSummary: UILabel!
    
    @IBOutlet var secondItemImage: UIImageView!
    @IBOutlet var secondItemValue: UILabel!
    @IBOutlet var secondItemDescription: UILabel!
    @IBOutlet var secondItemSummary: UILabel!
    
    @IBOutlet var thirdItemImage: UIImageView!
    @IBOutlet var thirdItemValue: UILabel!
    @IBOutlet var thirdItemDescription: UILabel!
    @IBOutlet var thirdItemSummary: UILabel!
    
    @IBOutlet var fourthItemImage: UIImageView!
    @IBOutlet var fourthItemValue: UILabel!
    @IBOutlet var fourthItemDescription: UILabel!
    @IBOutlet var fourthItemSummary: UILabel!
    
}

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
