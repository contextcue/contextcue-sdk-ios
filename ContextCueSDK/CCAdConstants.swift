//
//  CCAdConstants.swift
//  ContextCueSDK
//
//  Created by Jacob Roschen on 4/6/19.
//  Copyright © 2019 ContextCue. All rights reserved.
//

import Foundation

public enum AdSize: Int, CaseIterable {
	case MobileLeaderboard = 7
	case LargeMobileBanner = 6
	case MediumRectangle = 1
	case Leaderboard = 5
}

public extension AdSize {
	var width: CGFloat {
		switch self {
		case .MobileLeaderboard: return 320
		case .LargeMobileBanner: return 320
		case .MediumRectangle: return 300
		case .Leaderboard: return 714
		}
	}
	var height: CGFloat {
		switch self {
		case .MobileLeaderboard: return 50
		case .LargeMobileBanner: return 100
		case .MediumRectangle: return 250
		case .Leaderboard: return 90
		}
	}
	var size: CGSize {
		return CGSize(width: self.width, height: self.height)
	}
}

@objc public enum CCAdError: Int {
	case InternalError = 0
	case MissingAppIdentifier
	case MissingAdIdentifier
	case InvalidAdSize
	case NetworkError
	case NoInventory
}
