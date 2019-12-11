//
//  FeedTableViewCellViewModel.swift
//  PikaTest
//
//  Created by Александр Бочкарев on 04.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import Foundation
import UIKit


protocol FeedTableViewCellViewModelProtocol {

	var titleText: String { get }
	var previewText: String { get }
	var ratingText: String { get }

	init(titleText: String, previewText: String, rating: Int)
}


struct FeedTableViewCellViewModel: FeedTableViewCellViewModelProtocol {

	private(set) var titleText: String = ""
	private(set) var previewText: String = ""
	private(set) var ratingText: String = ""
	
	init(titleText: String, previewText: String, rating: Int) {
		self.titleText = titleText
		self.previewText = previewText
		self.ratingText = "❤️ \(rating)"
	}
}
