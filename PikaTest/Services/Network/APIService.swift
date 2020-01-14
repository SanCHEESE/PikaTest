//
//  APIService.swift
//  PikaTest
//
//  Created by Александр Бочкарев on 04.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import Foundation


final class APIService: APIServiceProtocol {

	let session: URLSession
	let decoder: DecoderProtocol

	init(configuration: URLSessionConfiguration = .default, decoder: DecoderProtocol = JSONDecoder()) {
		self.session = URLSession(configuration: configuration)
		self.decoder = decoder
	}

	func getFeed(from endpoint: FeedEndpoint, completion: @escaping (Result<FeedResult?, APIError>) -> Void) {
		guard let request = endpoint.request else {
			completion(.failure(.badUrl))
			return
		}

		fetch(with: request, decode: { json -> FeedResult? in
			guard let feedResult = json as? FeedResult else { return nil }
			return feedResult
		}, completion: completion)
	}

	func getPost(from endpoint: PostEndpoint, completion: @escaping (Result<PostResult?, APIError>) -> Void) {
		guard let request = endpoint.request else {
			completion(.failure(.badUrl))
			return
		}

		fetch(with: request, decode: { json -> PostResult? in
			guard let postResult = json as? PostResult else { return nil }
			return postResult
		}, completion: completion)
	}
}
