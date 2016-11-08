//
//  Extensions.swift
//  Necktie
//
//  Created by Ondra Kandera on 7/11/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import Foundation

extension Double {
    func toArc() -> Double {
        return (self * 0.01) * 360.0
    }
}
