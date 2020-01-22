//
//  APIServiceProtocol.swift
//  PikaTest
//
//  Created by Александр Бочкарев on 04.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import Foundation

/// API Errors
/// - badUrl -
/// - requestFailed -
/// - jsonConversionFailure -
/// - invalidData -
/// - responseUnsuccessful -
/// - jsonParsingFailure -
enum APIError: LocalizedError, Error {
	case badUrl
	case requestFailed
	case jsonConversionFailure
	case invalidData
	case responseUnsuccessful
	case jsonParsingFailure
}

extension APIError {

	var localizedDescription: String {
		switch self {
		case .badUrl:
			return "Bad url".localized
		case .requestFailed:
			return "Request Failed".localized
		case .invalidData:
			return "Invalid data".localized
		case .responseUnsuccessful:
			return "Response Unsuccessful".localized
		case .jsonConversionFailure:
			return "JSON Conversion Failure".localized
		case .jsonParsingFailure:
			return "JSON Parsing Failure".localized
		}
	}
}

protocol APIServiceProtocol: AnyObject {

	var session: URLSession { get }
	var decoder: DecoderProtocol { get }

	func fetch<T: Storable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)

	func getFeed(from endpoint: FeedEndpoint, completion: @escaping (Result<FeedResult, APIError>) -> Void)
	func getPost(from endpoint: PostEndpoint, completion: @escaping (Result<PostResult, APIError>) -> Void)
}

extension APIServiceProtocol {
	typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void

	private func decodingTask<T: Storable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {

		let task = session.dataTask(with: request) { data, response, error in
			guard let httpResponse = response as? HTTPURLResponse else {
				completion(nil, .requestFailed)
				return
			}
			if 200..<300 ~= httpResponse.statusCode {
				if let data = data {
					do {
						let genericModel = try self.decoder.decode(decodingType, from: data)
						completion(genericModel, nil)
					} catch {
						completion(nil, .jsonConversionFailure)
					}
				} else {
					completion(nil, .invalidData)
				}
			} else {
				completion(nil, .responseUnsuccessful)
			}
		}
		return task
	}

	func fetch<T: Storable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {

		let task = decodingTask(with: request, decodingType: T.self) { (json , error) in
			DispatchQueue.global().async {
				guard let json = json else {
					if let error = error {
						completion(.failure(error))
					} else {
						completion(.failure(.invalidData))
					}
					return
				}
				if let value = decode(json) {
					completion(.success(value))
				} else {
					completion(.failure(.jsonParsingFailure))
				}
			}
		}
		task.resume()
	}
}
