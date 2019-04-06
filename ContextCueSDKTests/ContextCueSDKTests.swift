//
//  ContextCueSDKTests.swift
//  ContextCueSDKTests
//
//  Created by Jacob Roschen on 4/6/19.
//  Copyright © 2019 ContextCue. All rights reserved.
//

import XCTest
@testable import ContextCueSDK

class ContextCueTests: XCTestCase {

    func testShouldShareASingleInstance() {
        let firstInstance = ContextCueSDK.shared
		firstInstance.refreshInterval = TimeInterval(60)
		
		let secondInstance = ContextCueSDK.shared
		XCTAssertEqual(firstInstance.refreshInterval, secondInstance.refreshInterval)
    }
}
