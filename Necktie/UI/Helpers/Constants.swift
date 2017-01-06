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
public struct Constant {
    #if DEBUG
        static var clientId = "2_1zxf66rtd32848cw8s00k0wcs0k0sg4so4g8o08ogw0g8gg4k4"
        static var clientSecret = "2l3ytusjnzc48gcog0skk88880soss4kc4gwgs0s408cgwwkww"
    #else
        static var clientId = "1_i6rapb3zuc8cgo8sgkogk80g0o8co40o0kkwowok0s4skocc4"
        static var clientSecret = "5jszcq44v84cgsocs8o00ko0k88og0g4ccw0408o44848ok8o0"
    #endif
    
    struct App {
        static let bundleId: String = Bundle.main.bundleIdentifier!
        static let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        static let build: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }
}

/// User Access Token
public struct Token {
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
}

/// Storyboard view controller identifiers
public struct Identifier {
    static let login = "login"
    
    static let products = "products"
    static let productDetail = "productDetail"
    
    static let users = "users"
    static let userDetail = "userDetail"
    
    static let billingPlans = "billingPlans"
    static let billingPlanDetail = "billingPlanDetail"
}

/// Storyboard segue identifiers
public struct Segue {
    static let productToProductDetail = "products->productDetail"
    static let usersToUserDetail = "users->userDetail"
    static let productDetailToBillingPlan = "productDetail->billingPlan"
}

/// SwiftyUserDefaults keys
public extension DefaultsKeys {
    static let isLoggedIn = DefaultsKey<Bool>("isLoggedIn")
    static let username = DefaultsKey<String>("username")
    static let introAnimation = DefaultsKey<Bool>("introAnimation")
    static let currency = DefaultsKey<String>("currency")
}
