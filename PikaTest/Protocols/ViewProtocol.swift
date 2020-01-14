//
//  ViewProtocol.swift
//  PikaTest
//
//  Created by Александр Бочкарев on 04.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import Foundation

protocol ViewProtocol: AnyObject {
	associatedtype ViewModel = ViewModelProtocol
	
	var viewModel: ViewModel? { set get }
}
