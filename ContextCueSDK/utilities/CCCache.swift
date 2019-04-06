//
//  CCImageCache.swift
//  ContextCueSDK
//
//  Created by Jacob Roschen on 4/6/19.
//  Copyright © 2019 ContextCue. All rights reserved.
//  A very simple FIFO cache
//

import Foundation

class CCCache<T: Codable> {
	private var maxItems: Int
	private var items: [String : T] = [:]
	// The keys array is to ensure that we can track the order items were added
	private var keys: [String] = []
	
	init(maxItems: Int = 10) {
		self.maxItems = maxItems
	}
	
	public func set(_ key: String, item: T) {
		if (items.count >= self.maxItems) {
			items.removeValue(forKey: keys.removeFirst())
		}
		
		keys.append(key)
		items[key] = item
	}
	
	public func get(_ key: String) -> T? {
		return self.items[key]
	}
}
