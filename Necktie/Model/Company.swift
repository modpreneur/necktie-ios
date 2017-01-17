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
    var city: String?
    var postalCode: String?
    var address: String?
    var logo: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        businessName <- map["business_name"]
        country <- map["country"]
        city <- map["city"]
        postalCode <- map["postal_code"]
        address <- map["address1"]
        logo <- map["logo_s3_key"]
    }
}
