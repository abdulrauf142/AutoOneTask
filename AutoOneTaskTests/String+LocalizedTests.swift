//
//  String+LocalizedTests.swift
//  AutoOneTaskTests
//
//  Created by Abdul Rauf on 03/11/2019.
//  Copyright © 2019 Abdul Rauf. All rights reserved.
//

import XCTest
import Foundation
import Combine

@testable import AutoOneTask

class LocalizedTests: XCTestCase {
    
    func testLocalization() {
        XCTAssertEqual("KEY_TITLE_MANUFACTURER_LIST".localized, "Manufacturer")
        
    }
}
