//
//  SectionHeaderView.swift
//  Necktie
//
//  Created by Ondra Kandera on 18/11/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

class SectionHeaderView: UIView {

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.lineWidth = 0.5
        
        UIColor.lightGray.setStroke()
        
        path.stroke()
    }

}
