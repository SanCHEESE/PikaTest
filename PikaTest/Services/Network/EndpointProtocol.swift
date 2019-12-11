//
//  Endpoint.swift
//  PikaTest
//
//  Created by Alexander Bochkarev on 10.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import Foundation


protocol EndpointProtocol {
	var base: String { get }
	var path: String { get }
}

extension EndpointProtocol {
	var urlComponents: URLComponents {
		var components = URLComponents(string: base)!
		components.path = "/files/api201910" + path
		return components
	}

	var request: URLRequest {
		let url = urlComponents.url!
		return URLRequest(url: url)
	}
}
