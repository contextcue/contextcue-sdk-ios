//
//  CCAutoAdBannerView.swift
//  ContextCueSDK
//
//  Created by Jacob Roschen on 4/9/19.
//  Copyright © 2019 ContextCue. All rights reserved.
//

import UIKit

@IBDesignable @objc public final class CCAdBannerView: CCAdBannerBaseView {
	public init(id: String, adSize: AdSize, origin: CGPoint) {
		super.init(id: id, frame: CGRect(origin: origin, size: adSize.size), size: adSize)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	public func setSize(_ size: AdSize) {
		self.size = size
	}
}
