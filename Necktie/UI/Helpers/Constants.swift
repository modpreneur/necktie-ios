//
//  Constants.swift
//  Necktie
//
//  Created by Ondra Kandera on 30/9/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import Foundation
import UIKit

import Alamofire
import KeychainAccess
import SwiftyUserDefaults

/// Global constants
struct Constant {
    static var clientId = "1_i6rapb3zuc8cgo8sgkogk80g0o8co40o0kkwowok0s4skocc4"
    static var clientSecret = "5jszcq44v84cgsocs8o00ko0k88og0g4ccw0408o44848ok8o0"
    
    struct App {
        static var bundleId: String = Bundle.main.bundleIdentifier!
        static var version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        static var build: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }
}

/// User Access Token
struct Token {
    /// Returns current user's access token
    static func getAccessToken() -> String {
        let keychain = Keychain(service: Constant.App.bundleId)
        
        if let accessToken = keychain["access_token"] {
            return accessToken
        } else {
            return ""
        }
    }
    
    static func getRefreshToken() -> String {
        let keychain = Keychain(service: Constant.App.bundleId)
        
        if let refreshToken = keychain["refresh_token"] {
            return refreshToken
        } else {
            return ""
        }
    }
    
    /// Constructs and returns HTTP headers with access token
    static func requestHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = ["Authorization": "Bearer " + Token.getAccessToken()]
        
        return headers
    }
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
    static let currency = DefaultsKey<String>("currency")
}
