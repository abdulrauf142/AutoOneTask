//
//  RecordRepositoryTests.swift
//  AutoOneTaskTests
//
//  Created by Abdul Rauf on 03/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import XCTest
import Foundation
import Combine

@testable import AutoOneTask

class RecordRepositoryTests: XCTestCase {
    
    var recordRepository: RecordRepositoryType?
    
    override func setUp() {
        recordRepository = RecordRepository(with: MockNetworkManager())
    }
    
    func testValidResponse() {
    
        let finshed = expectation(description: "testValidResponse.finished")
        let failed = expectation(description: "testValidResponse.failed")
        let success = expectation(description: "testValidResponse.finished")
        failed.isInverted = true
    
        let publisher = recordRepository?.fetchRecords(with: Query(type: .manufacturer, page: 1, pageSize: 2))
        let cancelable = publisher?.sink(receiveCompletion: { result in
            
            switch result {
            case .failure(_):
                failed.fulfill()
            case .finished:
                finshed.fulfill()
            }
            
        }, receiveValue: { response in
            success.fulfill()
        })
        
        wait(for: [finshed,failed,success], timeout: 1.0)
        cancelable?.cancel()
    }
}

struct MockNetworkManager: Fetchable {
    
    func fetch<T>(from endpoint: T) -> AnyPublisher<T.Response, NetworkError> where T : EndPoint {
        Future <T.Response, NetworkError> { promise in
            promise(.success(MockRecord.response as! T.Response))
        }.eraseToAnyPublisher()
    }
}

struct MockRecord {
    static var response: RecordResponse {
        let data = ["1": "one"]
        let response = RecordResponse(page: 1, pageSize: 20, totalPageCount: 2, manufacturer: data)
        return response
    }
}
