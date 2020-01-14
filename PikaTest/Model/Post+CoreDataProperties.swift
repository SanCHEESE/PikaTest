//
//  Post+CoreDataProperties.swift
//  PikaTest
//
//  Created by Александр Бочкарев on 04.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//
//

import Foundation
import CoreData


/// Post + CoreData
extension Post {
	
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }
}

/// Post + PostEntity
extension Post: PostEntity {

	@NSManaged public var id: Int64
	@NSManaged public var timeshamp: Double
	@NSManaged public var title: String?
	@NSManaged public var previewText: String?
	@NSManaged public var likesCount: Int64
	@NSManaged public var text: String?
	@NSManaged public var imageUrls: [String]?
}
