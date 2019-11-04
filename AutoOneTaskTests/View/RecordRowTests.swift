//
//  RecordRowTests.swift
//  AutoOneTaskTests
//
//  Created by Abdul Rauf on 03/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import Foundation
import XCTest
import SwiftUI
@testable import AutoOneTask

class RecordRowTests: XCTestCase {
    
    func testRecordRowConfiguration() {
        
        let row = RowBuilder.row(with: nil, onAppear: nil)
        XCTAssertNotNil(row as? AnyView)
    }
}
