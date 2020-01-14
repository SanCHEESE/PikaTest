//
//  CoordinatorProtocol.swift
//  PikaTest
//
//  Created by Александр Бочкарев on 04.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import UIKit


protocol CoordinatorProtocol: AnyObject {

	var navigationController: UINavigationController { get }
	
	init(navigationController: UINavigationController)
	
	/// starts its flow
	func start(with object: Any?)
	
	/// presents error alert
	func presentErrorAlert(with error: Error)
}

extension CoordinatorProtocol {
	
	func presentErrorAlert(with error: Error) {
		let alertController = UIAlertController(title: "Error".localized, message: error.localizedDescription, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
		self.navigationController.present(alertController, animated: true, completion: nil)
	}
}
