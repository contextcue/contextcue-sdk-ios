//
//  CCAdFetch.swift
//  ContextCueSDK
//
//  Created by Jacob Roschen on 4/6/19.
//  Copyright © 2019 ContextCue. All rights reserved.
//

import Foundation
import os.log

private struct AdFetch: Codable {
	let slots: [AdSlot]
	var time: String? = nil
	var dow: Int? = nil
	var site: String? = nil
}

class CCAdFetch {
	private let session = URLSession(configuration: .default)
	private let imageFetch = CCImageFetch()
	private let decoder = JSONDecoder()
	private let encoder = JSONEncoder()
	
	public func fetch(_ identifier: String?, slot: AdSlot, completion: @escaping (_ slot: AdSlot, _ error: CCAdError?) -> Void) {
		guard let identifier = identifier else {
			os_log("identifier not provided", log: OSLog.adView, type: .error)
			return completion(slot, .MissingAppIdentifier)
		}
		
		guard let url = self.buildAdFetchURL(identifier, slot: slot) else {
			os_log("Unable to build ad fetch URL", log: OSLog.adView, type: .error)
			return completion(slot, .InternalError)
		}
		
		let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
			guard let data = data else {
				return completion(slot, .NetworkError)
			}
			
			guard let json = try? self.decoder.decode(ApiResult<AdFetch>.self, from: data) else {
				return completion(slot, .InternalError)
			}
			
			guard let jsonSlot = json.data.slots.first else {
				return completion(slot, .NoInventory)
			}
			
			guard let adURI = jsonSlot.adURI else {
				return completion(jsonSlot, .NoInventory)
			}
			
			self.imageFetch.fetch(adURI) { (imageData, error) in
				jsonSlot.imageData = imageData
				if error != nil {
					os_log("Unable to parse image data", log: OSLog.adView, type: .error)
					return completion(jsonSlot, .NoInventory)
				} else {
					return completion(jsonSlot, nil)
				}
			}
		}
		
		task.resume()
	}
	
	private func buildAdFetchURL(_ identifier: String, slot: AdSlot) -> URL? {
		let now = Date()
		let cal = Calendar.init(identifier: .gregorian)
		
		let dayOfWeek = cal.component(.weekday, from: now) - 1
		let hour = cal.component(.hour, from: now)
		let minute = cal.component(.minute, from: now)
		
		let adFetch = AdFetch(slots: [slot], time: String(format: "%02d:%02d", hour, minute), dow: dayOfWeek, site: identifier)
		
		if let jsonData = try? self.encoder.encode(adFetch), let jsonString = String(data: jsonData, encoding: .utf8), let encodedURL = "\(Settings.BaseURL.rawValue)/ad-fetch/serve?q=\(jsonString)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
			return URL(string: encodedURL)
		}
		
		return nil
	}
}
