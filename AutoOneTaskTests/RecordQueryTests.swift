//
//  RecordQueryTests.swift
//  AutoOneTaskTests
//
//  Created by Abdul Rauf on 03/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation
import XCTest
import Combine
@testable import AutoOneTask

class RecordQueryTests: XCTestCase {
    
    var query: Query?
    
    func testQueryForManafucturer() {
        let query = Query(type: .manufacturer, page: 0, pageSize: 20)
        let manufacturer = query.parameters["manufacturer"] as? String
        XCTAssertEqual(manufacturer, nil)
        XCTAssertEqual(query.model, nil)
    }
    
    func testQueryForCarModels() {
        let query = Query(type: .carModel, page: 0, pageSize: 20, model: "Test")
        let manufacturer = query.parameters["manufacturer"] as? String
        XCTAssertEqual(manufacturer, "Test")
        XCTAssertEqual(query.model, "Test")
    }
}
