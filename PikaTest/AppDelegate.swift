//
//  AppDelegate.swift
//  PikaTest
//
//  Created by Александр Бочкарев on 04.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	let appCoordinator = AppCoordinator()

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		window = UIWindow(frame: UIScreen.main.bounds)
		appCoordinator.start(with: window)
		
		return true
	}
}

