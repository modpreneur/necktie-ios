//
//  Product.swift
//  Necktie
//
//  Created by Ondra Kandera on 23/11/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import Foundation

import ObjectMapper

final class Product: Mappable {
    var id: Int?
    var name: String?
    var created: String?
    var updated: String?
    var billingPlans: [BillingPlan] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        created <- (map["created_at"], TransformDate())
        updated <- (map["updated_at"], TransformDate())
        billingPlans <- map["billing_plans"]
    }
}
