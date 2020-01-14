//
//  FeedCoordinator.swift
//  PikaTest
//
//  Created by Александр Бочкарев on 04.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import UIKit


protocol FeedCoordinatorProtocol: CoordinatorProtocol {

	func presentSwitchSortingActionSheet(completion: @escaping (_ sortBy: SortBy)->())

	func pushPostViewController(with post: PostEntity)
}

final class FeedCoordinator: NSObject, FeedCoordinatorProtocol {

	// MARK: - CoordinatorProtocol -

	var navigationController: UINavigationController
	
	required init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func start(with object: Any?) {
		
	}

	// MARK: - FeedCoordinatorProtocol - 
	
	func presentSwitchSortingActionSheet(completion: @escaping (_ sortBy: SortBy)->()) {
		let actionSheet = UIAlertController(title: "Pick sort mode", message: nil, preferredStyle: .actionSheet)
		actionSheet.addAction(UIAlertAction(title: "Default", style: .default, handler: { _ in
			completion(.id)
		}))
		actionSheet.addAction(UIAlertAction(title: "By Date ↓", style: .default, handler: { _ in
			completion(.date(.ascending))
		}))
		actionSheet.addAction(UIAlertAction(title: "By Date ↑", style: .default, handler: { _ in
			completion(.date(.descending))
		}))
		actionSheet.addAction(UIAlertAction(title: "By Likes ↓", style: .default, handler: { _ in
			completion(.likes(.ascending))
		}))
		actionSheet.addAction(UIAlertAction(title: "By Likes ↑", style: .default, handler: { _ in
			completion(.likes(.descending))
		}))
		
		self.navigationController.present(actionSheet, animated: true, completion: nil)
	}
	
	func pushPostViewController(with post: PostEntity) {
		let postCoordinator = PostCoordinator(navigationController: navigationController)
		postCoordinator.start(with: post)
	}

	lazy private var feedViewController: FeedViewController! = {
		return navigationController.viewControllers.first as! FeedViewController
	}()
}
