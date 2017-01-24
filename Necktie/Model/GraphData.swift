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
    var data: [[Int]] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
    
}
