//
//  RecordEndpointTests.swift
//  AutoOneTaskTests
//
//  Created by Abdul Rauf on 03/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation
import XCTest
import Combine

@testable import AutoOneTask

class RecordEndpointTests: XCTestCase {
    
    var endPoint: RecordEndPoint?
    
    override func setUp() {
        let query = Query(type: .manufacturer, page: 0, pageSize: 20, model: nil)
        endPoint = RecordEndPoint(with: query)
    }
    
    func testRecordEndpoint() {
        
        XCTAssertEqual(endPoint!.baseUrl.absoluteString, NetworkConstant.environmentUrl)
        XCTAssertEqual(endPoint!.httpMethod, HTTPMethod.get)
        
        XCTAssertEqual(endPoint!.path, "v1/car-types/manufacturer")
        let throwExpection = expectation(description: "throw.build.request")
        
        do {
            _ = try endPoint!.buildRequest()
           throwExpection.fulfill()
        } catch {
             
        }
        wait(for: [throwExpection], timeout: 1.0)
    }
}
