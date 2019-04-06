//
//  CCOSLog.swift
//  ContextCueSDK
//
//  Created by Jacob Roschen on 4/9/19.
//  Copyright © 2019 ContextCue. All rights reserved.
//

import os.log

extension OSLog {
	private static var subsystem = Bundle.main.bundleIdentifier!
	
	static let adView = OSLog(subsystem: subsystem, category: "Ad View")
}
