//
//  AppCoordinator.swift
//  PikaTest
//
//  Created by Alexander Bochkarev on 11.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import Foundation
import UIKit


class AppCoordinator {

	func start(with window: UIWindow?) {
		guard let window = window else {
			fatalError("No window!")
		}

		let feedViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
		let navigationViewController = UINavigationController(rootViewController: feedViewController)
		let feedCoordinator = FeedCoordinator(navigationController: navigationViewController)

		// TOOO: move to builder
		guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
			fatalError("Failed to retrieve context")
		}
		let decoder = JSONDecoder()
		let coreDataService = CoreDataService()
		decoder.userInfo[codingUserInfoKeyManagedObjectContext] = coreDataService.managedContext
		let apiService = APIService(decoder: decoder)
		
		feedViewController.viewModel = FeedViewModel(coordinator: feedCoordinator, apiService: apiService, cacheService: coreDataService)

		window.rootViewController = navigationViewController
		window.makeKeyAndVisible()
	}

}
