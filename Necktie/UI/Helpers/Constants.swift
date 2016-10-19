//
//  Constants.swift
//  Necktie
//
//  Created by Ondra Kandera on 30/9/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import Foundation
import UIKit

import SwiftyUserDefaults
import Locksmith

/// Global constants
struct Constant {
    
}

/// API Paths
struct API {
    static var BASE_URL = ""
}

/// Storyboard view controller identifiers
struct Identifier {
    static var login = "login"
}

/// SwiftyUserDefaults keys
extension DefaultsKeys {
    static let isLoggedIn = DefaultsKey<Bool>("isLoggedIn")
    static let username = DefaultsKey<String>("username")
    static let introAnimation = DefaultsKey<Bool>("introAnimation")
}

/// Locksmith saving to system keychain
struct NecktieAccount: ReadableSecureStorable, CreateableSecureStorable, DeleteableSecureStorable, GenericPasswordSecureStorable {
    let username: String
    let password: String
    
    let service = "Necktie"
    var account: String { return username }
    var data: [String: Any] {
        return ["password": password]
    }
}
