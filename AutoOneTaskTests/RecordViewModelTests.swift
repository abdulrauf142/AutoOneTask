//
//  RecordViewModelTests.swift
//  AutoOneTaskTests
//
//  Created by Abdul Rauf on 03/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//
import XCTest
import Foundation
import Combine

@testable import AutoOneTask

class RecordViewModelTests: XCTestCase {
     
    let recordListViewModel = RecordListViewModel(with: MockRecordUsecase())
        
    override func setUp() {
        recordListViewModel.fetchPage(for: 0)
    }
        
    func testRecordList() {
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(self.recordListViewModel.canFetchNextPage, "canFetchNextPage should true")
            XCTAssertTrue(self.recordListViewModel.isLastIndex(2), "should be the last index")
            XCTAssertTrue(self.recordListViewModel.nextPage == 1, "")
            XCTAssertNotNil(self.recordListViewModel.object(at: 0))
            XCTAssertTrue(self.recordListViewModel.rowsCount == 2)
        }
    }
}


struct MockRecordUsecase: RecordUsecaseType {
    
    func fetch(for index: Int, model: String?) -> AnyPublisher<RecordPage, NetworkError> {
        return Future <RecordPage, NetworkError> { promise in
             promise(.success(self.mockResponse()))
        }.eraseToAnyPublisher()
    }
    
    private func mockResponse() -> RecordPage {
        let data = ["1": "one", "2": "two", "3": "three"]
        let recordPage = RecordPage(with:RecordResponse(page: 0, pageSize: 20, totalPageCount: 2, manufacturer: data))
        return recordPage
    }
}
