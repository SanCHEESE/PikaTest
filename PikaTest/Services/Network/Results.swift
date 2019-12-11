//
//  FeedResult.swift
//  PikaTest
//
//  Created by Alexander Bochkarev on 10.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import Foundation


/// The JSON has a key called posts and its an array of posts
struct FeedResult: Decodable {
	let posts: [Post]?
}

/// The JSON has a key called post an its a post
struct PostResult: Decodable {
	let post: Post?
}
