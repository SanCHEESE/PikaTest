//
//  FeedTableViewCell.swift
//  PikaTest
//
//  Created by Александр Бочкарев on 04.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import Foundation
import UIKit

final class FeedTableViewCell: UITableViewCell, ViewProtocol {
	static let reuseIdentifier = "FeedTableViewCell"
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var previewTextLabel: UILabel!
	@IBOutlet weak var viewMoreButton: UIButton!
	@IBOutlet weak var ratingLabel: UILabel!
	var isExpanded: Bool = false
	var onReadFurtherTap: ((_ viewModel: FeedTableViewCellViewModelProtocol) -> ())?
	
	var viewModel: FeedTableViewCellViewModelProtocol? {
		didSet {
			guard let viewModel = self.viewModel else { return }
			titleLabel.text = viewModel.titleText
			previewTextLabel.text = viewModel.previewText
			ratingLabel.text = viewModel.ratingText
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		viewMoreButton.setTitle("Expand".localized, for: .normal)
	}
	
	@IBAction func readFurther(_ sender: Any) {
		if let actionBlock = onReadFurtherTap, let viewModel = self.viewModel {
			isExpanded = !isExpanded
			previewTextLabel.numberOfLines = isExpanded ? 0 : 2
			viewMoreButton.setTitle(isExpanded ? "Collapse".localized : "Expand".localized, for: .normal)
			actionBlock(viewModel)
		}
	}
}
