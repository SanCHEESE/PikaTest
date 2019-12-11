//
//  CacheService.swift
//  PikaTest
//
//  Created by Alexander Bochkarev on 11.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//
import Foundation


enum SortingOrder {
	case ascending
	case descending
}

enum SortBy {
	case id
	case date(SortingOrder)
	case likes(SortingOrder)
}


protocol CacheServiceProtocol {

	func getPosts(with sortDescriptor: NSSortDescriptor) -> [PostEntity]

	func getPost(with id: Int64) -> PostEntity?
}
