//
//  Company.swift
//  Necktie
//
//  Created by Ondra Kandera on 17/1/17.
//  Copyright © 2017 Necktie. All rights reserved.
//

import Foundation

import ObjectMapper

final class Company: Mappable {
    var id: Int?
    var businessName: String?
    var country: String?
    var region: String?
    var city: String?
    var postalCode: String?
    var address1: String?
    var address2: String?
    var logo: String?
    var contactPerson: String?
    var contactPersonEmail: String?
    var supportEmail: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        businessName <- map["business_name"]
        country <- map["country"]
        region <- map["region"]
        city <- map["city"]
        postalCode <- map["postal_code"]
        address1 <- map["address1"]
        address2 <- map["address2"]
        logo <- map["logo_s3_key"]
        contactPerson <- map["contact_person_name"]
        contactPersonEmail <- map["contact_person_email"]
        supportEmail <- map["support_email"]
    }
}
