//
//  CoordinatorProtocol.swift
//  PikaTest
//
//  Created by Александр Бочкарев on 04.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import UIKit

/// A coordinator protocol that sets up basic entity constraints
protocol CoordinatorProtocol: AnyObject {

	/// Navigation controller to manage stack
	var navigationController: UINavigationController { get }
	
	init(navigationController: UINavigationController)

	/// Start coordinators flow
	/// - Parameter object: an object to start with, its up on specific coordinator to accept it or not
	func start(with object: Any?)
	
	/// presents error alert
	func presentErrorAlert(with error: Error)
}.

extension CoordinatorProtocol {

	/// Present localized error
	/// - Parameter error: error
	func presentErrorAlert(with error: Error) {
		let alertController = UIAlertController(title: "Error".localized, message: error.localizedDescription, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
		self.navigationController.present(alertController, animated: true, completion: nil)
	}
}
