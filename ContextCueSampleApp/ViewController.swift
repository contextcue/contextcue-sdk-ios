//
//  ViewController.swift
//  ContextCueSampleApp
//
//  Created by Jacob Roschen on 4/7/19.
//  Copyright © 2019 ContextCue. All rights reserved.
//

import UIKit
import ContextCueSDK

class ViewController: UIViewController {
	@IBOutlet var bottomAd: CCAdBannerAutoSizeView!
	@IBOutlet var bottomAdNonAutoSizing: CCAdBannerView!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.programmaticAd()
		self.storyboardAd()
	}

	func programmaticAd() {
		//
		// Programmatically instantiate a banner view and position it at the top of the view
		//
		let x = (self.view.frame.width - CGFloat(AdSize.LargeMobileBanner.width)) / 2
		let contextCueAdView = CCAdBannerView(id: "xsbQ1Tq8V", adSize: .LargeMobileBanner, origin: CGPoint(x: x, y: 40))
		
		self.view.addSubview(contextCueAdView)
		contextCueAdView.loadAd()
	}
	
	func storyboardAd() {
		//
		// Add a banner view to the Storyboard, then add the required properties on load
		//
		self.bottomAd.id = "xsbQ1Tq8V"
		self.bottomAd.loadAd()

		
		self.bottomAdNonAutoSizing.id = "xsbQ1Tq8V"
		self.bottomAdNonAutoSizing.setSize(.LargeMobileBanner)
		self.bottomAdNonAutoSizing.loadAd()
	}
}

