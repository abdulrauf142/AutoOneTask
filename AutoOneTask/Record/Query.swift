//
//  Query.swift
//  AutoOneTask
//
//  Created by Abdul Rauf on 04/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation

struct Query {
    
    enum `Type` {
        case manufacturer
        case carModel
    }
    
    let type: Type
    let page: Int
    let pageSize: Int
    var model: String?
    
    var parameters: Parameters {
        var params: Parameters = [.page : page, .pageSize : pageSize]
        if let manufacturer = model, !manufacturer.isEmpty {
            params["manufacturer"] = manufacturer
        }
        return params.merging(NetworkConstant.defaultParams) { (current, _) in current }
    }
}

fileprivate extension String {
    static let page = "page"
    static let pageSize = "pageSize"
}
