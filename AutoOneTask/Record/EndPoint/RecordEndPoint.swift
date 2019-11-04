//
//  RecordEndPoint.swift
//  AutoOneTask
//
//  Created by Abdul Rauf on 04/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation

struct RecordEndPoint: EndPoint {
    
    typealias Response = RecordResponse
    
    // MARK:- Properties
    let query: Query
    var parameters: Parameters { query.parameters }
    
    var path: String {
        switch query.type {
        case .carModel:
            return "v1/car-types/main-types"
        case .manufacturer:
            return "v1/car-types/manufacturer"
        }
    }

    // MARK:- Initializers
    init(with query: Query) {
        self.query = query
    }
}
