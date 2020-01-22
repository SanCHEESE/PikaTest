//
//  ViewProtocol.swift
//  PikaTest
//
//  Created by Александр Бочкарев on 04.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import Foundation

/// A view protocol that sets up basic entity constraints
protocol ViewProtocol: AnyObject {
	associatedtype ViewModel = ViewModelProtocol

	/// View model to be set externally
	var viewModel: ViewModel? { set get }
}
