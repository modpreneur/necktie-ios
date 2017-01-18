//
//  User.swift
//  Necktie
//
//  Created by Ondra Kandera on 3/1/17.
//  Copyright © 2017 Necktie. All rights reserved.
//

import Foundation

import ObjectMapper

final class User: NSObject, Mappable, NSCoding {
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
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as? Int
        self.username = aDecoder.decodeObject(forKey: "username") as? String ?? nil
        self.firstName = aDecoder.decodeObject(forKey: "firstName") as? String ?? nil
        self.lastName = aDecoder.decodeObject(forKey: "lastName") as? String ?? nil
        self.phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as? String ?? nil
        self.website = aDecoder.decodeObject(forKey: "website") as? String ?? nil
        self.email = aDecoder.decodeObject(forKey: "email") as? String ?? nil
        self.country = aDecoder.decodeObject(forKey: "country") as? String ?? nil
        self.created = aDecoder.decodeObject(forKey: "created") as? String ?? nil
        self.updated = aDecoder.decodeObject(forKey: "updated") as? String ?? nil
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(username, forKey: "username")
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName ,forKey: "lastName")
        aCoder.encode(phoneNumber, forKey: "phoneNumber")
        aCoder.encode(website, forKey: "website")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(country, forKey: "country")
        aCoder.encode(created, forKey: "created")
        aCoder.encode(updated, forKey: "updated")
    }
    
    override init() {
        super.init()
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
