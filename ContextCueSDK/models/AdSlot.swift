//
//  AdSlot.swift
//  ContextCueSDK
//
//  Created by Jacob Roschen on 4/7/19.
//  Copyright © 2019 ContextCue. All rights reserved.
//

import Foundation

public class AdSlot: Codable {
	let id: String
	let h: CGFloat
	let w: CGFloat
	let fetchId: String?
	var adURI: String? = nil
	var redirectURI: String? = nil
	var imageData: Data? = nil
	
	init(id: String, height: CGFloat, width: CGFloat, fetchId: String? = nil) {
		self.id = id
		self.h = height
		self.w = width
		self.fetchId = fetchId
	}
	
	init(id: String, size: AdSize, fetchId: String? = nil) {
		self.id = id
		self.h = size.height
		self.w = size.width
		self.fetchId = fetchId
	}
}
