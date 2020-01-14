//
//  CoreDataService.swift
//  PikaTest
//
//  Created by Александр Бочкарев on 04.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import Foundation
import CoreData
import UIKit

/// A protocol for stubbing data service
protocol CoreDataServiceProtocol {

	/// CoreData persistent container
	var persistentContainer: NSPersistentContainer { get }

	/// Context for container
	var managedContext: NSManagedObjectContext { get }
}

/// Concrete CoreData Caching service
final class CoreDataService: CoreDataServiceProtocol {

	private(set) lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "PikaTest")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()

	private(set) lazy var managedContext: NSManagedObjectContext = {
		return persistentContainer.viewContext
	}()
}

// MARK: - Caching

extension CoreDataService: Caching {

	func getPost(with id: Int64) throws -> PostEntity? {
		let request: NSFetchRequest<Post> = Post.fetchRequest()
		request.predicate = NSPredicate(format: "id = %@", id)

		let post = try managedContext.fetch(request).first
		return post
	}

	func getPosts(with sortDescriptor: NSSortDescriptor) throws -> [PostEntity] {
		let request: NSFetchRequest<Post> = Post.fetchRequest()
		request.sortDescriptors = [sortDescriptor]
		
		let posts = try managedContext.fetch(request)
		return posts
	}
}
