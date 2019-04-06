//
//  CCCacheTests.swift
//  ContextCueSDKTests
//
//  Created by Jacob Roschen on 4/10/19.
//  Copyright © 2019 ContextCue. All rights reserved.
//

import XCTest
@testable import ContextCueSDK

class CCCacheTests: XCTestCase {
	
	func testShouldStoreAndReturnAnItem() {
		let cache = CCCache<Int>()
		let key = "my_key"
		let value = 2
		
		cache.set(key, item: value)
		
		XCTAssertEqual(cache.get(key), value)
	}
	
	func testShouldReturnNilIfItemDoesNotExist() {
		let cache = CCCache<Int>()
		let key = "my_key"
		
		XCTAssertNil(cache.get(key))
	}
	
	func testShouldStoreAndReturnTheCorrectItem() {
		let cache = CCCache<Int>()
		let key = "my_key"
		let value = 2
		
		cache.set("key 1", item: 1)
		cache.set(key, item: value)
		cache.set("key 3", item: 3)
		
		XCTAssertEqual(cache.get(key), value)
	}
	
	func testShouldPurgeCacheWhenReachingLimit() {
		let cache = CCCache<Int>(maxItems: 2)
		let key = "my_key"
		let value = 1
		
		cache.set(key, item: value)
		cache.set("key 2", item: 2)
		cache.set("key 3", item: 3)
		
		XCTAssertNil(cache.get(key))
		XCTAssertEqual(cache.get("key 2"), 2)
		XCTAssertEqual(cache.get("key 3"), 3)
	}
}
