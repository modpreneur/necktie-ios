//
//  TransformDate.swift
//  Necktie
//
//  Created by Ondra Kandera on 12/12/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import Foundation

import ObjectMapper

open class TransformDate: TransformType {
    public typealias Object = String
    public typealias JSON = String
    
    public init() { }
    
    open func transformFromJSON(_ value: Any?) -> String? {
        if let value = value {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let myDate = dateFormatter.date(from: value as! String)!
            
            dateFormatter.dateFormat = "MMM dd, YYYY hh:mm a"
            let convertedDate = dateFormatter.string(from: myDate)
            
            return convertedDate
        }
        return nil
    }
    
    open func transformToJSON(_ value: String?) -> String? {
        return value
    }
    
}
