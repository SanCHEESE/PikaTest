//
//  FeedResult.swift
//  PikaTest
//
//  Created by Alexander Bochkarev on 10.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import Foundation

protocol Cachable {
	func cache(with cache: Caching) throws
}

typealias Storable = Decodable & Cachable

/// The JSON has a key called posts and its an array of posts
struct FeedResult: Storable {
	let posts: [Post]?

	func cache(with cache: Caching) throws {
		guard let posts = self.posts else {
			return
		}
		try cache.clear()
		try posts.forEach {
			try cache.write(object: $0)
		}
	}
}

/// The JSON has a key called post an its a post
struct PostResult: Storable {
	let post: Post?

	func cache(with cache: Caching) throws {
		guard let post = self.post else {
			return
		}
		try cache.update(object: post)
	}
}
