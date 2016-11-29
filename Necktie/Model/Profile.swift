//
//  Profile.swift
//  Necktie
//
//  Created by Ondra Kandera on 29/11/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import Foundation

import ObjectMapper

class Profile: Mappable {
    var id: Int?
    var username: String?
    var email: String?
    var country: String?
    var roles: Array<String>?
    var updated: String?
    var isPublic: Bool?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        username <- map["username"]
        email <- map["email"]
        country <- map["country"]
        roles <- map["roles"]
        updated <- map["updated_at"]
        isPublic <- map["public"]
    }
}
