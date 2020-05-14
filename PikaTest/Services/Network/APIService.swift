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
    let cache: Caching

    init(configuration: URLSessionConfiguration = .default, decoder: DecoderProtocol = JSONDecoder(), cache: Caching = CoreDataService()) {
		self.session = URLSession(configuration: configuration)
		self.decoder = decoder
        self.cache = cache
	}

	func getFeed(from endpoint: FeedEndpoint, completion: @escaping (Result<FeedResult, APIError>) -> Void) {
		guard let request = endpoint.request else {
			completion(.failure(.badUrl))
			return
		}

		fetch(with: request, handleGenericModel: { (genericModel: Decodable) -> FeedResult? in
			guard let feedResult = genericModel as? FeedResult else { return nil }
            do {
                try feedResult.cache(with: self.cache)
            } catch let error {
                debugPrint("Caching FeedResult failed! Error: \(error.localizedDescription)")
                return nil
            }
            return feedResult
		}, completion: completion)
	}

	func getPost(from endpoint: PostEndpoint, completion: @escaping (Result<PostResult, APIError>) -> Void) {
		guard let request = endpoint.request else {
			completion(.failure(.badUrl))
			return
		}

		fetch(with: request, handleGenericModel: { (genericModel: Decodable) -> PostResult? in
			guard let postResult = genericModel as? PostResult else { return nil }
            do {
                try postResult.cache(with: self.cache)
            } catch let error {
                debugPrint("Caching PostResult failed! Error: \(error.localizedDescription)")
                return nil
            }
			return postResult
		}, completion: completion)
	}
}
