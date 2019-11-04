//
//  RecordResponse.swift
//  AutoOneTask
//
//  Created by Abdul Rauf on 04/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation
struct RecordResponse: Decodable {
    
    let page: Int
    let pageSize: Int
    let totalPageCount : Int
    let manufacturer: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case page, pageSize, totalPageCount
        case manufacturer = "wkda"
    }
}
