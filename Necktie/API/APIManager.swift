//
//  APIManager.swift
//  Necktie
//
//  Created by Ondra Kandera on 29/11/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import Foundation

import Alamofire

/// API Session Manager
open class APIManager: Alamofire.SessionManager {
    
    public static let sharedManager: SessionManager = {
        // Set default config
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        // Set retry handler for OAuth2
        let manager = Alamofire.SessionManager(configuration: configuration)
        let retrier = OAuth2RetryHandler(clientID: Constant.clientId, clientSecret: Constant.clientSecret, baseURLString: API.baseURL.dev, accessToken: Token.getAccessToken(), refreshToken: Token.getRefreshToken())
        manager.adapter = retrier
        manager.retrier = retrier
        
        return manager
    }()
    
    override init(configuration: URLSessionConfiguration, delegate: SessionDelegate, serverTrustPolicyManager: ServerTrustPolicyManager? = nil) {
        super.init(configuration: configuration, delegate: delegate, serverTrustPolicyManager: serverTrustPolicyManager)
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
