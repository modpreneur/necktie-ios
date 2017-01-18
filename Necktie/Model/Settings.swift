//
//  Settings.swift
//  Necktie
//
//  Created by Ondra Kandera on 18/1/17.
//  Copyright © 2017 Necktie. All rights reserved.
//

import Foundation

import ObjectMapper

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
