//
//  FeedViewModel.swift
//  PikaTest
//
//  Created by Александр Бочкарев on 04.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import Foundation
import UIKit


protocol FeedViewModelProtocol: ViewModelProtocol {

	var apiService: APIServiceProtocol { get }
	var cacheService: CacheServiceProtocol { get }

	var feedTableViewCellModels: [FeedTableViewCellViewModelProtocol]? { get }
	var onUpdate: (() -> ())? { set get }

	init(coordinator: FeedCoordinatorProtocol, apiService: APIServiceProtocol, cacheService: CacheServiceProtocol)

	func fetchFeed(completion: @escaping ViewModelCompletion)
	func changeSortingMode()
	func goToPost(at index: Int)
}


final class FeedViewModel: FeedViewModelProtocol {

	// MARK: - ViewModelProtocol -
	let coordinator: CoordinatorProtocol

	// MARK: - FeedViewModelProtocol -
	let apiService: APIServiceProtocol
	let cacheService: CacheServiceProtocol
	var feedTableViewCellModels: [FeedTableViewCellViewModelProtocol]? {
		return self.posts.map { post in
			FeedTableViewCellViewModel(titleText: post.title ?? "",
									   previewText: post.previewText ?? "",
									   rating: Int(post.likesCount))
		}
	}
	var onUpdate: (() -> ())?

	required init(coordinator: FeedCoordinatorProtocol,
				  apiService: APIServiceProtocol = APIService(),
				  cacheService: CacheServiceProtocol = CoreDataService())
	{
		self.coordinator = coordinator
		self.apiService = apiService
		self.cacheService = cacheService

		self.posts = self.cacheService.getPosts(with: NSSortDescriptor(key: "id", ascending: true))
	}

	func fetchFeed(completion: @escaping ViewModelCompletion) {
		apiService.getFeed(from: FeedEndpoint()) { [weak self] result in
			DispatchQueue.main.async {
				guard let `self` = self else {
					return
				}
				switch result {
				case .success(let feedResult):
					guard let posts = feedResult?.posts else {
						return
					}
					self.posts = posts

					completion(.success(true))
				case .failure(let error):
					completion(.failure(error))
				}
			}
		}
	}

	func changeSortingMode() {
		(coordinator as? FeedCoordinatorProtocol)?.presentSwitchSortingActionSheet { [unowned self] sortingMode in
			self.sorting = sortingMode
			self.onUpdate?()
		}
	}

	func goToPost(at index: Int) {
		(coordinator as? FeedCoordinatorProtocol)?.pushPostViewController(with: posts[index])
	}

	// MARK: - Private -

	private var sorting: SortBy = .id {
		didSet {
			sortPosts()
		}
	}

	private var posts: [PostEntity]

	private func sortPosts() {
		posts.sort(by: { (obj1, obj2) -> Bool in
			switch self.sorting {
			case .id:
				return obj1.id < obj2.id
			case .date(let ordering):
				return ordering == .ascending ? obj1.timeshamp < obj2.timeshamp : obj1.timeshamp > obj2.timeshamp
			case .likes(let ordering):
				return ordering == .descending ? obj1.likesCount < obj2.likesCount : obj1.likesCount > obj2.likesCount
			}
		})
	}
}
