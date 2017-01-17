//
//  Project.swift
//  Necktie
//
//  Created by Ondra Kandera on 17/1/17.
//  Copyright © 2017 Necktie. All rights reserved.
//

import Foundation

import ObjectMapper

final class Project: Mappable {
    var id: Int?
    var name: String?
    var company: Company?
    var isLocked: Bool?
    var color: String?
    var shippings: [String]?
    var created: String?
    var updated: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        company <- map["company"]
        isLocked <- map["locked"]
        color <- map["project_color"]
        shippings <- map["shippings"]
        created <- map["created"]
        updated <- map["updated"]
    }
}
