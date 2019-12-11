//
//  PostViewController.swift
//  PikaTest
//
//  Created by Александр Бочкарев on 04.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import UIKit

final class PostViewController: UITableViewController, ViewProtocol {
	
	var viewModel: PostViewModelProtocol? {
		didSet {
			reloadData()
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
				
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 44

		viewModel?.fetchPost { [weak self] result in
			guard let `self` = self else {
				return
			}
			
			switch result {
			case .success:
				self.reloadData()
			case .failure(let error):
				self.viewModel?.handleError(error: error)
			}
		}
	}
	
	func reloadData() {
		tableView.reloadData()
	}
}


// MARK: - TableView -

extension PostViewController { // TODO: Переместить во вью модел
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let viewModel = viewModel else { return 0 }
		
		let textAvailable = viewModel.text != nil ? 1 : 0
		let imagesCount = viewModel.imageUrls != nil ? viewModel.imageUrls!.count : 0
		return textAvailable + imagesCount
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			return tableView.dequeueReusableCell(withIdentifier: PostTextTableViewCell.reuseIdentifier)!
		} else {
			return tableView.dequeueReusableCell(withIdentifier: PostImageTableViewCell.reuseIdentifier)!
		}
	}
	
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		guard let viewModel = viewModel else { return }
		
		if cell is PostTextTableViewCell, let cell = cell as? PostTextTableViewCell {
			cell.textString = viewModel.text
		} else if cell is PostImageTableViewCell, let cell = cell as? PostImageTableViewCell {
			cell.onImageLoaded = { [weak self] in
				self?.tableView.beginUpdates()
				self?.tableView.endUpdates()
			}
			cell.imageUrl = viewModel.imageUrls?[indexPath.row - 1]
		}
	}
}
