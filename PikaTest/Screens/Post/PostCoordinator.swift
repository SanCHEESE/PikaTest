//
//  PostCoordinator.swift
//  PikaTest
//
//  Created by Александр Бочкарев on 04.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import UIKit


protocol PostCoordinatorProtocol: CoordinatorProtocol {
}


final class PostCoordinator: PostCoordinatorProtocol {
	var navigationController: UINavigationController
	
	required init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start(with object: PostEntity?) {
		guard let post = object else {
			return
		}

		let postViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PostViewController") as! PostViewController

		// TOOO: move to builder
		guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
			fatalError("Failed to retrieve context")
		}
		let decoder = JSONDecoder()
		let coreDataManager = CoreDataService()
		decoder.userInfo[codingUserInfoKeyManagedObjectContext] = coreDataManager.managedContext
		let apiService = APIService(decoder: decoder)
		postViewController.viewModel = PostViewModel(coordinator: self, post: post, apiService: apiService)

		navigationController.pushViewController(postViewController, animated: true)
	}
}
