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

// MARK: - CacheServiceProtocol

extension CoreDataService: CacheServiceProtocol {

	func getPost(with id: Int64) -> PostEntity? {
		let request: NSFetchRequest<Post> = Post.fetchRequest()

		request.predicate = NSPredicate(format: "id = %@", id)

		do {
			let post = try managedContext.fetch(request).first
			return post
		} catch {
			print(error)
			return nil
		}
	}

	func getPosts(with sortDescriptor: NSSortDescriptor) -> [PostEntity] {
		let request: NSFetchRequest<Post> = Post.fetchRequest()

		request.sortDescriptors = [sortDescriptor]

		do {
			let posts = try managedContext.fetch(request)
			return posts
		} catch {
			print(error)
			return []
		}
	}

}
