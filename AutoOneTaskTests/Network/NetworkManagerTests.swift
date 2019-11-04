//
//  NetworkManagerTests.swift
//  AutoOneTaskTests
//
//  Created by Abdul Rauf on 02/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import XCTest
import Foundation
@testable import AutoOneTask

class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager?
    var endpoint: RecordEndPoint?
    
    override func setUp() {
        
        
        endpoint = RecordEndPoint(with: Query(type: .manufacturer, page: 0, pageSize: 20, model: nil))
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        networkManager = NetworkManager(with: URLSession(configuration: config))
        
        let url = try! endpoint?.buildRequest().url!
        let reponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        MockURLProtocol.mocks[url!.path] = jsonString.data(using: .utf8)
        MockURLProtocol.response = reponse
    }
    
    func testFetch() {
        
        let finished = expectation(description: "expectation.finished")
        let success = expectation(description: "expectation.success")
        let failed = expectation(description: "expectation.failure")
        
        failed.isInverted = true
        
        let publisher = networkManager!.fetch(from: endpoint!)
        
        let cancelable = publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(_):
                failed.fulfill()
            case .finished:
                finished.fulfill()
            }
        }) { response in
            success.fulfill()
        }
        wait(for: [failed, success, finished], timeout: 2.0)
        cancelable.cancel()
    }
}

var jsonString: String {
    
    return """
    {
        "page": 0,
        "pageSize": 20,
        "totalPageCount": 4,
        "wkda": {
            "020": "Abarth",
            "040": "Alfa Romeo",
            "042": "Alpina",
            "057": "Aston Martin",
            "060": "Audi",
            "095": "Barkas",
            "107": "Bentley",
            "130": "BMW",
            "125": "Borgward",
            "145": "Brilliance",
            "141": "Buick",
            "150": "Cadillac",
            "157": "Caterham",
            "160": "Chevrolet",
            "170": "Chrysler",
            "190": "Citroen",
            "191": "Corvette",
            "189": "Cupra",
            "194": "Dacia",
            "195": "Daewoo"
        }
    }
"""
}

