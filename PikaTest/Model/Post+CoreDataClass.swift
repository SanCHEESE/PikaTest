//
//  Post+CoreDataClass.swift
//  PikaTest
//
//  Created by Александр Бочкарев on 04.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Post)
public class Post: NSManagedObject, PostEntity {

	enum CodingKeys: String, CodingKey {
		case id = "postId"
		case timeshamp
		case title
		case previewText = "preview_text"
		case text
		case likesCount = "likes_count"
		case imageUrls = "images"
	}

	// MARK: - Decodable
	public required convenience init(from decoder: Decoder) throws {
		guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
			let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
			let entity = NSEntityDescription.entity(forEntityName: "Post", in: managedObjectContext) else {
				fatalError("Failed to decode Post")
		}

		self.init(entity: entity, insertInto: managedObjectContext)

		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decodeIfPresent(Int64.self, forKey: .id) ?? -1
		self.timeshamp = try container.decodeIfPresent(Double.self, forKey: .timeshamp) ?? 0
		self.title = try container.decodeIfPresent(String.self, forKey: .title)
		self.previewText = try container.decodeIfPresent(String.self, forKey: .previewText)
		self.text = try container.decodeIfPresent(String.self, forKey: .text)
		self.likesCount = try container.decodeIfPresent(Int64.self, forKey: .likesCount) ?? 0
		self.imageUrls = try container.decodeIfPresent([String].self, forKey: .imageUrls)

		try managedObjectContext.save()
	}

	// MARK: - Encodable
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(timeshamp, forKey: .timeshamp)
		try container.encode(title, forKey: .title)
		try container.encode(previewText, forKey: .previewText)
		try container.encode(text, forKey: .text)
		try container.encode(likesCount, forKey: .likesCount)
		try container.encode(imageUrls, forKey: .imageUrls)
	}

}
