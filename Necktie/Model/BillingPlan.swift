//
//  BillingPlan.swift
//  Necktie
//
//  Created by Ondra Kandera on 12/12/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import Foundation

import ObjectMapper

final class BillingPlan: Mappable {
    var id: Int?
    var initialPrice: Double?
    var created: String?
    var updated: String?
    var itemId: String?
    var paySystemVendor: [String: Any] = [:]
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        initialPrice <- map["initial_price"]
        created <- (map["created_at"], TransformDate())
        updated <- (map["updated_at"], TransformDate())
        itemId <- map["item_id"]
    }
}

final class PaySystemVendor: Mappable {
    var id: Int?
    var name: String?
    var paySystem: [PaySystem] = []
    var setting: [String: String] = [:]
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        paySystem <- map["pay_system"]
        setting <- map["setting"]
    }
}

final class PaySystem: Mappable {
    var id: Int?
    var name: String?
    var vendors: [Any] = []
    var postback: Bool = true
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        vendors <- map["vendors"]
        postback <- map["postback"]
    }
}
