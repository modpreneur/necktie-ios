//
//  User.swift
//  Necktie
//
//  Created by Ondra Kandera on 3/1/17.
//  Copyright © 2017 Necktie. All rights reserved.
//

import Foundation

import ObjectMapper

final class User: Mappable {
    var id: Int?
    var username: String?
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
    var website: String?
    var email: String?
    var country: String?
    var roles: [String]?
    var created: String?
    var updated: String?
    var isPublic: Bool?
    var isExpired: Bool?
    var hasCredentialsExpired: Bool?
    var isLocked: Bool?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        username <- map["username"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        phoneNumber <- map["phone_number"]
        website <- map["website"]
        email <- map["email"]
        country <- map["country"]
        roles <- map["roles"]
        created <- (map["created_at"], TransformDate())
        updated <- (map["updated_at"], TransformDate())
        isPublic <- map["public"]
        isExpired <- map["expired"]
        hasCredentialsExpired <- map["credentials_expired"]
        isLocked <- map["locked"]
    }
}
