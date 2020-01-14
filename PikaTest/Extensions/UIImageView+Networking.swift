//
//  UIImageView+Networking.swift
//  PikaTest
//
//  Created by Alexander Bochkarev on 11.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import UIKit
import Foundation


/// Dumb image loading stuff
extension UIImageView {

	func setImageFrom(urlString: String, completion: @escaping ()->() = {}) {

		guard let url = URL(string: urlString) else {
			debugPrint("Specified string is not a URL")
			completion()
			return
		}
		self.setImageFrom(url: url)
	}

	func setImageFrom(url: URL, completion: @escaping ()->() = {}) {

		// check in cache
		if let image = imageFromCache(for: url) {
			DispatchQueue.main.async {
				self.image = image
			}
			completion()
			return
		}

		DispatchQueue.global().async {
			var data: Data?
			do {
				data = try Data(contentsOf: url)
			} catch {
				debugPrint("Cannot download image, error: \(error.localizedDescription)")
				completion()
				return
			}

			guard let imageData = data else {
				completion()
				return
			}

			self.save(imageData: imageData, for: url)
			let image = UIImage(data: imageData, scale: UIScreen.main.scale)
			DispatchQueue.main.async {
				self.image = image
				completion()
			}
		}
	}


	// MARK: - Private -

	private var imageExt: String {
		return ".png"
	}

	private func imageFromCache(for webUrl: URL) -> UIImage? {
		let key = self.imageKey(from: webUrl)

		guard let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .allDomainsMask).first else {
			debugPrint("No cache directory found!")
			return nil
		}
		let imageUrl = cacheDirectory.appendingPathComponent(key + imageExt)

		if !FileManager.default.fileExists(atPath: imageUrl.path) {
			debugPrint("No image for path: \(imageUrl.path) found in cache!")
			return nil
		}

		guard let imageData = try? Data(contentsOf: imageUrl) else {
			debugPrint("Cannot read file data at path: \(imageUrl.path)")
			return nil
		}

		let image = UIImage(data: imageData, scale: UIScreen.main.scale)
		return image
	}

	private func save(imageData: Data, for webUrl: URL) {
		let key = self.imageKey(from: webUrl)

		guard let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .allDomainsMask).first else {
			debugPrint("No cache directory found!")
			return
		}

		let imageUrl = cacheDirectory.appendingPathComponent(key + imageExt)

		do {
			try imageData.write(to: imageUrl, options: .atomic)
		} catch {
			debugPrint("Image not saved to file: \(error.localizedDescription)")
		}
	}

	private func imageKey(from url: URL) -> String {
		return String(url.path.replacingOccurrences(of: "/", with: "_").hashValue)
	}
}
