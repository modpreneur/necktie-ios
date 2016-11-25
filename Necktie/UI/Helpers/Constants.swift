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
    static var clientId: String = "1_i6rapb3zuc8cgo8sgkogk80g0o8co40o0kkwowok0s4skocc4"
    static var clientSecret: String = "5jszcq44v84cgsocs8o00ko0k88og0g4ccw0408o44848ok8o0"
    
    static var service: String = "com.getnecktie.Necktie"
}

/// API Paths
struct API {
    /// API Base URL
    static var BASE_URL: String = "http://dev.getnecktie.com"
    
    /// API Version
    static var Version: Int = 1
    
    static var APIPath: String = "/api/v" + "\(API.Version)" + "/"
    
    /// OAuth2 URL
    static var OAuthPath: String = "/oauth/v2/token"
    
    /// Paths
    static var Products: String = API.APIPath + "products"
}

/// User Access Token
struct AccessToken {
    /// Returns current user's access token
    static func getAccessToken() -> String {
        let keychain = Keychain(service: Constant.service)
        
        if let accessToken = keychain["access_token"] {
            return accessToken
        } else {
            return ""
        }
    }
    
    /// Constructs and returns HTTP headers with access token
    static func requestHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = ["Authorization": "Bearer " + AccessToken.getAccessToken()]
        
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
}
