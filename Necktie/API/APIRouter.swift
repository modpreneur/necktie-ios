//
//  APIRouter.swift
//  Necktie
//
//  Created by Ondra Kandera on 29/11/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import Foundation

import Alamofire

/// API Paths
struct API {
    /// API Base URL
    static var baseURL: String {
    #if DEBUG
        //return "http://88.146.49.119/app_dev.php"
        return "http://dev.getnecktie.com"
    #else
        return "http://dev.getnecktie.com"
    #endif
    }
    
    /// OAuth2 URL
    static var OAuthPath = "/oauth/v2/token"
    
    /// API Version
    static var version = 1
    static var path = "/api/v" + "\(API.version)" + "/"
    
    /// Paths
    static var products = API.path + "products"
    static var product = API.path + "product"
    static var users = API.path + "users"
    static var user = API.path + "user"
    static var profile = API.path + "profile"
    static var settings = API.path + "settings"
    static var billingPlan = API.path + "billing-plan"
    static var invoices = API.path + "invoices"
}

/// API Router, returns URLConvertible
enum Router: URLRequestConvertible {
    static let baseURLString = API.baseURL
    
    case product(id: Int)
    case products
    case user(id: Int)
    case users
    case profile
    case settings
    case billingPlan(id: Int)
    case invoice(id: Int)
    case invoices
    case invoiceItems(id: Int)
    
    func asURLRequest() throws -> URLRequest {
        let result: (path: String, method: HTTPMethod, parameters: Parameters) = {
            switch self {
            case .products:
                return (API.products, .get, [:])
            case let .product(id):
                return (API.product + "/\(id)", .get, [:])
            case .users:
                return (API.users, .get, [:])
            case let .user(id):
                return (API.user + "/\(id)", .get, [:])
            case .profile:
                return (API.profile, .get, [:])
            case .settings:
                return (API.settings, .get, [:])
            case let .billingPlan(id):
                return (API.billingPlan + "/\(id)", .get, [:])
            case let .invoice(id):
                return (API.invoices + "/\(id)", .get, [:])
            case .invoices:
                return (API.invoices, .get, [:])
            case let .invoiceItems(id):
                return (API.invoices + "\(id)" + "/items", .get, [:])
            }
        }()
        
        let url = try Router.baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(result.path))
        
        urlRequest.httpMethod = result.method.rawValue
        
        if result.parameters.count > 0 {
            return try JSONEncoding.default.encode(urlRequest, with: result.parameters)
        } else {
            return try URLEncoding.default.encode(urlRequest, with: result.parameters)
        }
    }
}
