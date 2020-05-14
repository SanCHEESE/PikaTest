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
	case writeError
    case updateError

	var localizedDescription: String {
		switch self {
		case .notFound:
			return "Not found".localized
		case .writeError:
			return "Can not write to cache".localized
        case .updateError:
            return "Cannot update object in cache".localized
		}
	}
}

/// Protocol which should be implemented with caching service
protocol Caching {

	/// Delete all data from cache
	func clear() throws

	/// Write new object to cache
	/// - Parameter object: post entity
	func write(object: PostEntity) throws

    /// Update object in cache
    /// - Parameter object: post entity
    func update(object: PostEntity) throws

	/// Fetch all posts with given sorting
	/// - Parameter sortDescriptor: sort descriptor
	func getPosts(with sortDescriptor: NSSortDescriptor) throws -> [PostEntity]

	/// Get post with specified identifier
	/// - Parameter id: post id
	func getPost(with id: Int64) throws -> PostEntity?
}
