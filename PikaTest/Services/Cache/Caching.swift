//
//  CacheService.swift
//  PikaTest
//
//  Created by Alexander Bochkarev on 11.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//
import Foundation

/// A error related to caching
enum CachingError: LocalizedError, Error {
	case notFound

	var localizedDescription: String {
		switch self {
		case .notFound:
			return "Not found".localized
		}
	}
}

/// Protocol which should be implemented with caching service
protocol Caching {

	/// Fetch all posts with given sorting
	/// - Parameter sortDescriptor: sort descriptor
	func getPosts(with sortDescriptor: NSSortDescriptor) throws -> [PostEntity]

	/// Get post with specified identifier
	/// - Parameter id: post id
	func getPost(with id: Int64) throws -> PostEntity?
}