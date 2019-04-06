//
//  ApiResult.swift
//  ContextCueSDK
//
//  Created by Jacob Roschen on 4/7/19.
//  Copyright © 2019 ContextCue. All rights reserved.
//

import Foundation

class ApiResult<T: Codable>: Codable {
	let errors: [String]
	let status: String
	let data: T
}
