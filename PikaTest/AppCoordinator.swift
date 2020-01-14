//
//  AppCoordinator.swift
//  PikaTest
//
//  Created by Alexander Bochkarev on 11.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import Foundation
import UIKit

/// Coordinator that starts app
final class AppCoordinator {

	func start(with window: UIWindow?) {
		guard let window = window else {
			fatalError("No window!")
		}

		window.rootViewController = AppBuilder().buildInitialNavigationStack()
		window.makeKeyAndVisible()
	}
}
