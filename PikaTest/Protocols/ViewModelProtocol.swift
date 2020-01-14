//
//  ViewModelProtocol.swift
//  PikaTest
//
//  Created by Александр Бочкарев on 04.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import Foundation
import CoreData


protocol ViewModelProtocol {

	var coordinator: CoordinatorProtocol { get }
}

extension ViewModelProtocol {
	func handleError(error: Error) {
		coordinator.presentErrorAlert(with: error)
	}
}
