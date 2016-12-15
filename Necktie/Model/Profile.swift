//
//  Profile.swift
//  Necktie
//
//  Created by Ondra Kandera on 29/11/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import Foundation

import ObjectMapper

final class Profile: Mappable {
    var id: Int?
    var username: String?
    var email: String?
    var country: String?
    var roles: [String]?
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
        updated <- (map["updated_at"], TransformDate())
        isPublic <- map["public"]
    }
}

final class Settings: Mappable {
    var date: String?
    var time: String?
    var dateTime: String?
    var currency: String?
    var vat: Int?
    var itemsOnPage: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        date <- map["date"]
        time <- map["time"]
        dateTime <- map["date_time"]
        currency <- map["currency"]
        vat <- map["vat"]
        itemsOnPage <- map["items_on_page"]
    }
}
