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
        return "http://88.146.49.119/app_dev.php"
        //return "http://dev.getnecktie.com"
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
    case products(limit: Int, skip: Int, sort: String, direction: Sort)
    case user(id: Int)
    case users(limit: Int, skip: Int)
    case profile
    case settings
    case billingPlan(id: Int)
    case invoice(id: Int)
    case invoices(limit: Int, skip: Int, sort: String, direction: Sort)
    case invoiceItems(id: Int, limit: Int, skip: Int, sort: String, direction: Sort)
    
    func asURLRequest() throws -> URLRequest {
        let result: (path: String, method: HTTPMethod, parameters: Parameters) = {
            switch self {
            case let .products(limit, skip, sort, direction):
                return (API.products, .get, ["limit": limit, "skip": skip, "sort": sort, "direction": direction])
                
            case let .product(id):
                return (API.product + "/\(id)", .get, [:])
                
            case let .users(limit, skip):
                return (API.users, .get, ["limit": limit, "skip": skip])
                
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
                
            case let .invoices(limit, skip, sort, direction):
                return (API.invoices, .get, ["limit": limit, "skip": skip, "sort": sort, "direction": direction])
                
            case let .invoiceItems(id, limit, skip, sort, direction):
                return (API.invoices + "\(id)" + "/items", .get, ["limit": limit, "skip": skip, "sort": sort, "direction": direction])
                
            }
        }()
        
        let url = try Router.baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(result.path))
        
        urlRequest.httpMethod = result.method.rawValue
        
        return try URLEncoding.default.encode(urlRequest, with: result.parameters)
    }
}

public enum Sort: String {
    case asc = "asc"
    case desc = "desc"
}
