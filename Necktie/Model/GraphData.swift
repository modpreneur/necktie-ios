//
//  GraphData.swift
//  Necktie
//
//  Created by Ondra Kandera on 24/1/17.
//  Copyright © 2017 Necktie. All rights reserved.
//

import Foundation

import ObjectMapper

final class GraphData: Mappable {
    var type: GraphType?
    var dataNames: [String]?
    var xAxisName: String?
    var xAxis: [Int]?
    var data: [[Int]] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        dataNames <- map["dataNames"]
        xAxisName <- map["xAxisName"]
        xAxis <- map["xAxis"]
        data <- map["data"]
    }
    
}

public enum GraphType: String {
    case areaSpline = "area-spline"
}
