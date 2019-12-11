//
//  Feed.swift
//  PikaTest
//
//  Created by Alexander Bochkarev on 10.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//


import Foundation

let BaseUrl = "http://cs.pikabu.ru/files/api201910"

struct FeedEndpoint: EndpointProtocol {
	var base: String {
		return BaseUrl
	}

	var path: String {
		return "/posts.json"
	}
}

struct PostEndpoint: EndpointProtocol {
	private let postId: Int

	init(postId: Int) {
		self.postId = postId
	}

	var base: String {
		return BaseUrl
	}

	var path: String {
		return "/\(postId).json"
	}
}
