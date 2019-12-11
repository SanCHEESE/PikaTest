//
//  PostEntity.swift
//  PikaTest
//
//  Created by Alexander Bochkarev on 11.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import Foundation


protocol PostEntity: Codable {

	var id: Int64 { set get }
	var timeshamp: Double { set get }
	var title: String? { set get }
	var previewText: String? { set get }
	var likesCount: Int64 { set get }
	var text: String? { set get }
	var imageUrls: [String]? { set get }

}
