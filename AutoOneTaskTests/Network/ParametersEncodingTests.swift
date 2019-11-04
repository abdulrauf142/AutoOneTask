//
//  ParametersEncodingTests.swift
//  AutoOneTaskTests
//
//  Created by Abdul Rauf on 03/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import XCTest
import Foundation
import Combine
@testable import AutoOneTask

class ParameterEncodingSpecs: XCTestCase {
    
    let encoding = ParameterEncoding.urlEncoding
    var request = URLRequest(url:  URL(string: "http://api-aws-eu-qa-1.auto1-test.com/v1/car-types")!)
    
    func testWhenParameterNil() {
        
        XCTAssertThrowsError(try encoding.encode(urlRequest: &request, params: nil)) { error in
            XCTAssertEqual(error as! NetworkError, NetworkError.nilParameters)
        }
    }
    
    func testParameterEncoding() {
        try! encoding.encode(urlRequest: &request, params: ["page": 1])
        XCTAssertNotNil(request.url)
        XCTAssertEqual(request.url!.absoluteString, "http://api-aws-eu-qa-1.auto1-test.com/v1/car-types?page=1")
    }
}
