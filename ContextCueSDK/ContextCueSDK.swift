//
//  ContextCueSDK.swift
//  ContextCueSDK
//
//  Created by Jacob Roschen on 4/7/19.
//  Copyright © 2019 ContextCue. All rights reserved.
//

import Foundation

public class ContextCueSDK {
	// This is a singleton, that way we only need the consumer to initialize it once when the app loads
	public static let shared = ContextCueSDK()
	private let adFetch: CCAdFetch
	public var identifier: String?
	
	private init() {
		adFetch = CCAdFetch()
	}
	
	func fetch(_ slot: AdSlot, completion: @escaping (_ slot: AdSlot, _ error: CCAdError?) -> Void) {
		self.adFetch.fetch(identifier, slot: slot, completion: completion)
	}
	
	private var _refreshInterval = TimeInterval(15) // TODO: Revert this
	public var refreshInterval: TimeInterval {
		get {
			return _refreshInterval
		}
		set {
			if newValue >= 15 {
				_refreshInterval = newValue
			}
		}
	}
}
