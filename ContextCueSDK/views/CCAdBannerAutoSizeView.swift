//
//  CCAutoAdBannerView.swift
//  ContextCueSDK
//
//  Created by Jacob Roschen on 4/9/19.
//  Copyright © 2019 ContextCue. All rights reserved.
//

import UIKit

@IBDesignable @objc public final class CCAdBannerAutoSizeView: CCAdBannerBaseView {
	public override func loadAd() {
		self.computeAdSize()
		super.loadAd()
	}
	
	private func computeAdSize() {
		let availableSizes = AdSize.allCases.filter { $0.height <= frame.height && $0.width <= frame.width }
		
		var finalSize: AdSize?
		var diff = CGFloat.greatestFiniteMagnitude
		
		for size in availableSizes {
			let thisDiff = (frame.width - size.width) + (frame.height - size.height)
			if (thisDiff < diff) {
				diff = thisDiff
				finalSize = size
			}
		}
		
		self.size = finalSize
	}
	
	override public func layoutSubviews() {
		let currentSize = self.size
		self.computeAdSize()
		if (currentSize != self.size) {
			self.loadAd()
		}
		
		super.layoutSubviews()
	}
}
