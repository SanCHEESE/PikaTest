//
//  PostEntity.swift
//  PikaTest
//
//  Created by Alexander Bochkarev on 11.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import Foundation

/// Sort field of Post entities
enum SortBy {
	case id
	case date(Order)
	case likes(Order)

	/// Sorting order
	enum Order {
		case ascending
		case descending
	}

	/// Sort descriptor
	var sortDescriptor: NSSortDescriptor {
		switch self {
		case .id:
			return NSSortDescriptor(key: "id", ascending: true)
		case .date(let order):
			return NSSortDescriptor(key: "timeshamp", ascending: order == .ascending)
		case .likes(let order):
			return NSSortDescriptor(key: "likesCount", ascending: order == .ascending)
		}
	}
}

/// Post protocol
protocol PostEntity: Codable {

	var id: Int64 { set get }
	var timeshamp: Double { set get }
	var title: String? { set get }
	var previewText: String? { set get }
	var likesCount: Int64 { set get }
	var text: String? { set get }
	var imageUrls: [String]? { set get }
	
}
