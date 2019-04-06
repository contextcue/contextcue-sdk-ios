//
//  CCAdBannerBaseView.swift
//  ContextCueSDK
//
//  Created by Jacob Roschen on 4/9/19.
//  Copyright © 2019 ContextCue. All rights reserved.
//

import Foundation
import UIKit
import os.log

@IBDesignable @objc public class CCAdBannerBaseView: UIView {
	public var id: String?
	@IBOutlet public weak var delegate: CCAdViewDelegate?
	public internal(set) var size: AdSize?
	internal private(set) var image: UIImage?
	internal private(set) var redirectUrl: URL?
	internal private(set) var centeredSubView: UIView?
	internal private(set) weak var timer: Timer?
	public var autoRefresh = true {
		didSet {
			self.startTimer()
		}
	}
	
	public init(id: String, frame: CGRect, size: AdSize? = nil) {
		self.id = id
		self.size = size
		
		super.init(frame: frame)
		
		self.backgroundColor = .clear
		self.setupNotifications()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setupNotifications()
	}
	
	private func setupNotifications() {
		NotificationCenter.default.addObserver(self, selector: #selector(pauseTimer), name: UIApplication.willResignActiveNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(startTimer), name: UIApplication.willEnterForegroundNotification, object: nil)
	}
	
	@objc public func loadAd() {
		self.pauseTimer()
		guard let id = self.id else {
			os_log("'id' property must be set on the banner view before loading an ad", log: OSLog.adView, type: .error)
			delegate?.failedToLoadAd?(self, .MissingAdIdentifier)
			return
		}
		guard let adSize = self.size else {
			os_log("'size' property must be set on the banner view before loading an ad", log: OSLog.adView, type: .error)
			delegate?.failedToLoadAd?(self, .InvalidAdSize)
			return
		}
		
		ContextCueSDK.shared.fetch(AdSlot(id: id, size: adSize)) { (slot, error) in
			if let redirectURI = slot.redirectURI, let imageData = slot.imageData {
				self.redirectUrl = URL(string: redirectURI)
				self.render(imageData)
				self.delegate?.didReceiveAd?(self)
			} else {
				self.delegate?.failedToLoadAd?(self, .NoInventory)
				os_log("Unable to load an ad", log: OSLog.adView, type: .error)
			}
			
			self.startTimer()
		}
	}
	
	func render(_ data: Data) {
		guard let image = UIImage(data: data) else {
			return
		}
		
		guard let size = self.size else {
			return
		}
		
		self.image = image
		
		DispatchQueue.main.async {
			if let currentSubView = self.centeredSubView {
				currentSubView.removeFromSuperview()
				self.centeredSubView = nil
			}
			
			let centeredSubView = UIImageView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
			centeredSubView.image = image
			centeredSubView.backgroundColor = .clear
			centeredSubView.contentMode = .scaleAspectFit
			
			centeredSubView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapHandler(_:))))
			centeredSubView.isUserInteractionEnabled = true
		
			self.isUserInteractionEnabled = true
			self.addSubview(centeredSubView)
			self.centeredSubView = centeredSubView
		}
	}
	
	func center() {
		if let centeredSubView = self.centeredSubView {
			centeredSubView.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
		}
	}
	
	override public func layoutSubviews() {
		self.center()
		super.layoutSubviews()
	}
	
	deinit {
		pauseTimer()
	}
	
	@objc func tapHandler(_ sender: UITapGestureRecognizer) {
		// Open the link in safari
		guard let link = self.redirectUrl else {
			os_log("Invalid redirect link", log: OSLog.adView, type: .error)
			return
		}
		
		self.delegate?.adWasTapped?(self)
		UIApplication.shared.open(link)
	}
	
	@objc func pauseTimer() {
		timer?.invalidate()
		self.timer = nil
	}
	
	@objc func startTimer() {
		pauseTimer()
		
		if !self.autoRefresh {
			return
		}
		
		DispatchQueue.main.async { [weak self] in
			self?.timer = Timer.scheduledTimer(withTimeInterval: ContextCueSDK.shared.refreshInterval, repeats: false) { [weak self] timer in
				self?.loadAd()
			}
		}
	}
}
