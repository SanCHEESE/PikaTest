//
//  CoreDataServiceProtocol.swift
//  PikaTest
//
//  Created by Alexander Bochkarev on 05.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import Foundation
import CoreData


protocol CoreDataServiceProtocol {

	var persistentContainer: NSPersistentContainer { get }
	var managedContext: NSManagedObjectContext { get }

}
