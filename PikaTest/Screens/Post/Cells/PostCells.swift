//
//  PostTextTableViewCell.swift
//  PikaTest
//
//  Created by Alexander Bochkarev on 04.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import UIKit
import Foundation


final class PostImageTableViewCell: UITableViewCell {
	static let reuseIdentifier = "PostImageTableViewCell"

	// cell already has image view
	@IBOutlet weak var imView: UIImageView!
	
	var onImageLoaded: (()->()) = {}
	
	var imageUrl: URL! {
		didSet {
			imView.setImageFrom(url: self.imageUrl, completion: {
				DispatchQueue.main.async {
					self.onImageLoaded()
				}
			})
		}
	}
}

final class PostTextTableViewCell: UITableViewCell {
	static let reuseIdentifier = "PostTextTableViewCell"
	
	var textString: String? {
		didSet {
			textLabel?.text = textString
		}
	}
}
