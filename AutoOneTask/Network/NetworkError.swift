//
//  NetworkError.swift
//  AutoOneTask
//
//  Created by Abdul Rauf on 02/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation
import SwiftUI
enum NetworkError: LocalizedError {
    
    case invalidURL
    case nilParameters
    case nilRequest
    case parseError
    case transformError
    case unknowError
    
    var errorDescription: String? {
       switch self {
        case .invalidURL:
            return "KEY_INVALID_URL"
        case .nilParameters:
            return "KEY_PARAMETERS_NIL"
        case .nilRequest:
            return "KEY_NIL_REQUEST"
       case .parseError, .transformError:
            return "KEY_JSON_PARSING_FAILED"
       case .unknowError:
        return "KEY_NETWORK_ERROR"
        
        }
    }
}
