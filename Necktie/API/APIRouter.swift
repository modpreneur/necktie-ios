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
        //return "http://ci.corp.modpreneur.com:8000"
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
    static var projects = API.path + "projects"
    static var companies = API.path + "companies"
    static var company = API.path + "company"
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
    case projects(limit: Int, skip: Int)
    case companies(limit: Int, skip: Int)
    case company(id: Int, limit: Int, skip: Int)
    
    func asURLRequest() throws -> URLRequest {
        let result: (path: String, method: HTTPMethod, parameters: Parameters) = {
            switch self {
                
            // MARK: Products
            case let .products(limit, skip, sort, direction):
                return (API.products, .get, ["limit": limit, "skip": skip, "sort": sort, "direction": direction])
                
            // MARK: Product
            case let .product(id):
                return (API.product + "/\(id)", .get, [:])
                
            // MARK: Users
            case let .users(limit, skip):
                return (API.users, .get, ["limit": limit, "skip": skip])
                
            // MARK: User
            case let .user(id):
                if id == 0 {
                    return (API.user, .get, [:])
                } else {
                    return (API.user + "/\(id)", .get, [:])
                }
                
            // MARK: Profile
            case .profile:
                return (API.profile, .get, [:])
                
            // MARK: Settings
            case .settings:
                return (API.settings, .get, [:])
                
            // MARK: Billing Plan
            case let .billingPlan(id):
                return (API.billingPlan + "/\(id)", .get, [:])
                
            // MARK: Invoice
            case let .invoice(id):
                return (API.invoices + "/\(id)", .get, [:])
                
            // MARK: Invoices
            case let .invoices(limit, skip, sort, direction):
                return (API.invoices, .get, ["limit": limit, "skip": skip, "sort": sort, "direction": direction])
                
            // MARK: Invoice Items
            case let .invoiceItems(id, limit, skip, sort, direction):
                return (API.invoices + "\(id)" + "/items", .get, ["limit": limit, "skip": skip, "sort": sort, "direction": direction])
                
            // MARK: Projects
            case let .projects(limit, skip):
                return (API.projects, .get, ["limit": limit, "skip": skip])
            
            // MARK: Companies
            case let .companies(limit, skip):
                return (API.companies, .get, ["limit": limit, "skip": skip])
            
            // MARK: Company
            case let .company(id, limit, skip):
                return (API.company + "/\(id)" + "/projects", .get, ["limit": limit, "skip": skip])
        
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
