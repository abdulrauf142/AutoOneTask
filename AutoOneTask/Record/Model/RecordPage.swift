//
//  RecordPage.swift
//  AutoOneTask
//
//  Created by Abdul Rauf on 04/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation

struct RecordPage {
    
    // MARK:- Properties
    var records: [Record]
    let current: Int
    let count: Int
    
    // MARK:- Initializers
    init(with response: RecordResponse) {
        
        var manufacturer = response.manufacturer.map { key, value in
            Record(id: key, name: value)
        }
        
        manufacturer.sort { $0.name < $1.name }
        
        records = manufacturer
        current = response.page
        count = response.totalPageCount
    }
}
