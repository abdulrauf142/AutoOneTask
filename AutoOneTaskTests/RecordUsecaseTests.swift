//
//  RecordUsecaseTests.swift
//  AutoOneTaskTests
//
//  Created by Abdul Rauf on 03/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation
import XCTest
import Combine
@testable import AutoOneTask

class RecordUsecaseTests: XCTestCase {
    
    let usecase = RecordUsecase(with: MockRecordRepository())
    
    func testQueryForManafucturer() {
        
        let publisher = usecase.fetch(for: 0, model: "Test")
        
        let finished = expectation(description: "expectation.finished")
        let success = expectation(description: "expectation.success")
        let failed = expectation(description: "expectation.failure")
        
        failed.isInverted = true

        let cancelable = publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(_):
                failed.fulfill()
            case .finished:
                finished.fulfill()
            }
        }) { records in
            success.fulfill()
            XCTAssertNotNil(records)
            XCTAssertTrue(records.records.count > 0, "records count should be greater then one for page one")
        }
        
        wait(for: [finished,failed,success], timeout: 1.0)
        cancelable.cancel()
        
    }
}

// MARK:- MockRecordRepository
struct MockRecordRepository: RecordRepositoryType {
    
    func fetchRecords(with query: Query) -> AnyPublisher<RecordResponse, NetworkError> {
        Future <RecordResponse, NetworkError> { promise in
            promise(.success(self.mockResponse()))
        }.eraseToAnyPublisher()
    }
    
    private func mockResponse() -> RecordResponse {
        
        let data = ["1": "one"]
        let response = RecordResponse(page: 1, pageSize: 20, totalPageCount: 2, manufacturer: data)
        return response
    }
    
}
