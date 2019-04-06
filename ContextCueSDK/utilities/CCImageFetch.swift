//
//  CCImageFetch.swift
//  ContextCueSDK
//
//  Created by Jacob Roschen on 4/9/19.
//  Copyright © 2019 ContextCue. All rights reserved.
//

import Foundation

class CCImageFetch {
	private let session = URLSession(configuration: .default)
	private let imageCache = CCCache<Data>()
	
	public func fetch(_ url: String, completion: @escaping (_ image: Data?, _ error: String?) -> Void) {
		if let imageData = self.imageCache.get(url) {
			return completion(imageData, nil)
		}
		
		guard let adImageURL = URL(string:  url) else {
			return completion(nil, "Unable to build ad image url")
		}
		
		let downloadImageTask = self.session.dataTask(with: adImageURL) { (data, response, error) in
			if let e = error {
				return completion(nil, "Error downloading ad image: \(e)")
			}
			
			if (response as? HTTPURLResponse) == nil {
				return completion(nil, "The response was not valid")
			}
			
			guard let imageData = data else {
				return completion(nil, "The data wasn't an image")
			}
			
			// Finally cache the image data and return it
			self.imageCache.set(url, item: imageData)
			return completion(imageData, nil)
		}
		
		downloadImageTask.resume()
	}
}
