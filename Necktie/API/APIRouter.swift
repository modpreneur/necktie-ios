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
    struct baseURL {
        static var production: String = "http://dev.getnecktie.com"
        static var dev: String = "http://dev.getnecktie.com"
    }
    
    /// OAuth2 URL
    static var OAuthPath: String = "/oauth/v2/token"
    
    /// API Version
    static var version: Int = 1
    static var path: String = "/api/v" + "\(API.version)" + "/"
    
    /// Paths
    static var products: String = API.path + "products"
    static var product: String = API.path + "product"
    static var users: String = API.path + "users"
    static var user: String = API.path + "user"
    static var profile: String = API.path + "profile"
}

/// API Router, returns URLConvertible
enum Router: URLRequestConvertible {
    static let baseURLString = API.baseURL.dev
    
    case product(id: Int)
    case products
    case user(id: Int)
    case users
    case profile
    
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
