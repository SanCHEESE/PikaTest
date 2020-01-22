//
//  CodingUserInfoKey+CoreData.swift
//  PikaTest
//
//  Created by Alexander Bochkarev on 10.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import Foundation

public extension CodingUserInfoKey {
	// Helper property to retrieve the context
	static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
