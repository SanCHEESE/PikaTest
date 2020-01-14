//
//  FeedViewController.swift
//  PikaTest
//
//  Created by Александр Бочкарев on 04.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import UIKit


final class FeedViewController: UITableViewController, ViewProtocol {

	// MARK: - ViewProtocol -

	var viewModel: FeedViewModelProtocol? {
		didSet {
			if var viewModel = self.viewModel {
				viewModel.onUpdate = { [unowned self] in
					self.reloadData()
				}
				reloadData()
			}
			
		}
	}

	// MARK: - UIViewController -
	
	override func viewDidLoad() {
		super.viewDidLoad()
			
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 130
		tableView.refreshControl = UIRefreshControl()
		tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
		
		setupNavigationBar()
		
		refresh(nil)
	}
	
	func setupNavigationBar()
	{
		title = "Feed".localized
		let doneItem = UIBarButtonItem(title: "Sort".localized, style: .plain, target: self, action: #selector(changeSortingMode(_:)))
		self.navigationItem.rightBarButtonItem = doneItem
	}
	
	func reloadData() {
		tableView.reloadData()
	}
	
	// MARK: - Actions -
	
	@objc func refresh(_ sender: Any?) {
		guard let viewModel = viewModel else {
			return
		}
		
		// set animating refresh only if data was loaded before
		if let refreshControl = refreshControl, let _ = viewModel.feedTableViewCellModels {
			refreshControl.beginRefreshing()
			tableView.setContentOffset(CGPoint(x: 0, y: -refreshControl.frame.size.height), animated: true)
		}
		
		
		viewModel.fetchFeed { [weak self] result in
			guard let self = self else {
				return
			}
			
			// stop refresh animation
			self.refreshControl?.endRefreshing()
			
			switch result {
			case .success:
				self.reloadData()
			case .failure(_):
				break // do nothing
			}
			
		}
	}
	
	@IBAction func changeSortingMode(_ sender: Any?) {
		viewModel?.changeSortingMode()
	}
}


// MARK: - TableView -
extension FeedViewController { // TODO: Move to view model
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel?.feedTableViewCellModels?.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseIdentifier)!
	}
	
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if let cell = cell as? FeedTableViewCell,
			let cellViewModel = viewModel?.feedTableViewCellModels?[indexPath.row] {
			cell.viewModel = cellViewModel
			cell.onReadFurtherTap = { tableCellViewModel in
				tableView.beginUpdates()
				tableView.endUpdates()
			}
		}
		
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		viewModel?.goToPost(at: indexPath.row)
	}
}

