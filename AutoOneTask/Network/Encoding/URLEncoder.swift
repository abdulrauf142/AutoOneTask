//
//  URLEncoder.swift
//  AutoOneTask
//
//  Created by Abdul Rauf on 02/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation

fileprivate extension String {
    static let urlFormEncoded = "application/x-www-form-urlencoded; charset=utf-8"
    static let contentType = "Content-Type"
}

struct URLEncoder: ParameterEncodable {
    
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else { throw NetworkError.invalidURL }
        
        if var components = URLComponents(url: url,
                                          resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            components.queryItems = [URLQueryItem]()
            
            let items = parameters.map { key , value in
                return URLQueryItem(name: key, value: "\(value)")
            }
            components.queryItems = items
            urlRequest.url = components.url
        }
        
        if urlRequest.value(forHTTPHeaderField: .contentType) == nil {
            urlRequest.setValue(.urlFormEncoded, forHTTPHeaderField: .contentType)
        }
    }
}
