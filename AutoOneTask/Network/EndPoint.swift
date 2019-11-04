//
//  EndPoint.swift
//  AutoOneTask
//
//  Created by Abdul Rauf on 02/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation

protocol EndPoint {
    
    associatedtype Response: Decodable
    
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    
    //MARK: Optional values
    var parameters: Parameters { get }
    var httpHeader: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
    var baseUrl: URL { get }
}

// Default bahviour of optinal property
extension EndPoint {
   
    var baseUrl: URL {
       
        guard let url = URL(string: NetworkEnvironment.staging.environmentUrl)
            else {
            fatalError("unable to create the base URL")
        }
        return url
    }
    var httpMethod: HTTPMethod { return .get }
    var httpHeader: HTTPHeaders? { return nil }
    var encoding: ParameterEncoding { return .urlEncoding }
    
    func buildRequest() throws -> URLRequest {
        
        var request = URLRequest(url: path.isEmpty ? baseUrl : baseUrl.appendingPathComponent(path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: RequestTimeout.fifteen.rawValue)
        
        request.httpMethod = httpMethod.rawValue
        
        do {
            try encoding.encode(urlRequest: &request, params: parameters)
        } catch {
            throw error
        }
        
        return request
    }
}
