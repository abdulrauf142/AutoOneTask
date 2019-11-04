//
//  ParameterEncodable.swift
//  AutoOneTask
//
//  Created by Abdul Rauf on 02/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation
protocol ParameterEncodable {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

enum ParameterEncoding {
    
    case urlEncoding
    
    func encode(urlRequest: inout URLRequest, params: Parameters?) throws {
        
        guard let parameters = params else { throw NetworkError.nilParameters }
        
        do {
            switch self {
            case .urlEncoding:
                try URLEncoder().encode(urlRequest: &urlRequest, with: parameters)
            }
        } catch {
            throw error
        }
    }
}
