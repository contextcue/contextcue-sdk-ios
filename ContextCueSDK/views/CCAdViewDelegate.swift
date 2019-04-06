//
//  CCViewDelegate.swift
//  ContextCueSDK
//
//  Created by Jacob Roschen on 4/13/19.
//  Copyright © 2019 ContextCue. All rights reserved.
//

import Foundation

@objc public protocol CCAdViewDelegate: class {
	@objc optional func didReceiveAd(_ view: CCAdBannerBaseView)
	
	@objc optional func failedToLoadAd(_ view: CCAdBannerBaseView, _ error: CCAdError)
	
	@objc optional func adWasTapped(_ view: CCAdBannerBaseView)
}
