//
//  ViewController.swift
//  ContextCueSampleApp
//
//  Created by Jacob Roschen on 4/7/19.
//  Copyright © 2019 ContextCue. All rights reserved.
//

import UIKit
import ContextCueSDK

class ViewController: UIViewController, CCAdViewDelegate {
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
		let contextCueAdView = CCAdBannerView(id: "V7VQIFsj", adSize: .LargeMobileBanner, origin: CGPoint(x: x, y: 40))
		
		self.view.addSubview(contextCueAdView)
		contextCueAdView.loadAd()
	}
	
	func storyboardAd() {
		//
		// Add a banner view to the Storyboard, then add the required properties on load
		//
		self.bottomAd.id = "V7VQIFsj"
		self.bottomAd.loadAd()
		self.bottomAd.delegate = self;

		
		self.bottomAdNonAutoSizing.id = "V7VQIFsj"
		self.bottomAdNonAutoSizing.setSize(.LargeMobileBanner)
		self.bottomAdNonAutoSizing.loadAd()
	}
	
	func didReceiveAd(_ view: CCAdBannerBaseView) {
		print("Delegate: Ad Loaded")
	}
	
	func failedToLoadAd(_ view: CCAdBannerBaseView, _ error: CCAdError) {
		print("Delegate: Unable to load ad")
	}
	
	func adWasTapped(_ view: CCAdBannerBaseView) {
		print("Delegate: Ad tapped")
	}
}

