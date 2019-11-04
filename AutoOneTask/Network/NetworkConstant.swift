//
//  NetworkConstant.swift
//  AutoOneTask
//
//  Created by Abdul Rauf on 02/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation

enum HTTPMethod : String {
    case get     = "GET"
    case post    = "POST"
}

typealias Parameters = [String: Any]
typealias HTTPHeaders = [String: String]

enum RequestTimeout: TimeInterval {
    case fifteen = 15.0
}

struct NetworkConstant {
    static let environmentUrl = NetworkEnvironment.staging.environmentUrl
    static let apiKey = "65a10a157609bad989cc2d236bd81325"
    static let defaultParams: Parameters = ["wa_key" : "coding-puzzle-client-449cc9d"]
}
// Environment
enum NetworkEnvironment: String {
    
    case staging
    
    var environmentUrl: String {
        switch self {
            case .staging:
                return "http://api-aws-eu-qa-1.auto1-test.com"
        }
    }
}
