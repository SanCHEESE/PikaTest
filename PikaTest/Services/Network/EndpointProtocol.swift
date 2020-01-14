//
//  Endpoint.swift
//  PikaTest
//
//  Created by Alexander Bochkarev on 10.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import Foundation

/// A protocol for backend endpoint
protocol EndpointProtocol {
	var base: String { get }
	var path: String { get }
}

extension EndpointProtocol {

	/// An accessor for url components
	var urlComponents: URLComponents? {
		guard var components = URLComponents(string: base) else {
			return nil
		}
		components.path = "/files/api201910" + path
		return components
	}

	var request: URLRequest? {
		guard let url = urlComponents?.url else {
			return nil
		}
		return URLRequest(url: url)
	}
}
