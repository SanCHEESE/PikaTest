//
//  ViewModelProtocol.swift
//  PikaTest
//
//  Created by Александр Бочкарев on 04.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import Foundation
import CoreData

/// A view model protocol that sets up basic entity constraints
protocol ViewModelProtocol {

	/// Coordinator that helps manage navigation
	var coordinator: CoordinatorProtocol { get }
}

extension ViewModelProtocol {

	/// Show error alert
	/// - Parameter error: error
	func handleError(error: Error) {
		coordinator.presentErrorAlert(with: error)
	}
}
