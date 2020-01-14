//
//  AppBuilder.swift
//  PikaTest
//
//  Created by Alexander Bochkarev on 13.01.2020.
//  Copyright © 2020 Александр Бочкарев. All rights reserved.
//

import UIKit

/// Concrete app builder
final class AppBuilder { // TODO: think about generalization

	func buildInitialNavigationStack() -> UINavigationController {
		let feedViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
		let navigationViewController = UINavigationController(rootViewController: feedViewController)
		let feedCoordinator = FeedCoordinator(navigationController: navigationViewController)

		guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
			fatalError("Failed to retrieve context")
		}
		let decoder = JSONDecoder()
		let coreDataService = CoreDataService()
		decoder.userInfo[codingUserInfoKeyManagedObjectContext] = coreDataService.managedContext
		let apiService = APIService(decoder: decoder)

		feedViewController.viewModel = FeedViewModel(coordinator: feedCoordinator, apiService: apiService, cacheService: coreDataService)

		return navigationViewController
	}
}
