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
	var cacheService: Caching { get }

	var feedTableViewCellModels: [FeedTableViewCellViewModelProtocol]? { get }
	var onUpdate: (() -> ())? { set get }

	init(coordinator: FeedCoordinatorProtocol, apiService: APIServiceProtocol, cacheService: Caching)

	func fetchFeed(completion: @escaping (Result<Void, Error>)->())
	func changeSortingMode()
	func goToPost(at index: Int)
}


final class FeedViewModel: FeedViewModelProtocol {

	// MARK: - ViewModelProtocol -
	let coordinator: CoordinatorProtocol

	// MARK: - FeedViewModelProtocol -
	let apiService: APIServiceProtocol
	let cacheService: Caching
	var feedTableViewCellModels: [FeedTableViewCellViewModelProtocol]? {
		return posts.map { post in
			FeedTableViewCellViewModel(titleText: post.title ?? "",
									   previewText: post.previewText ?? "",
									   rating: Int(post.likesCount))
		}
	}
	var onUpdate: (() -> ())?

	required init(coordinator: FeedCoordinatorProtocol,
				  apiService: APIServiceProtocol = APIService(),
				  cacheService: Caching = CoreDataService())
	{
		self.coordinator = coordinator
		self.apiService = apiService
		self.cacheService = cacheService

		do {
			self.posts = try self.cacheService.getPosts(with: SortBy.id.sortDescriptor)
		} catch {
			coordinator.presentErrorAlert(with: error)
		}
		
		self.posts = []
	}

	func fetchFeed(completion: @escaping (Result<Void, Error>)->()) {
		apiService.getFeed(from: FeedEndpoint()) { [weak self] result in
			DispatchQueue.main.async {
				guard let self = self else {
					return
				}

				switch result {
				case .success(let feedResult):
					guard let posts = feedResult?.posts else {
						return
					}
					self.posts = posts

					completion(.success(()))
				case .failure(let error):
					completion(.failure(error))
					self.handleError(error: error)
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
			do {
				self.posts = try cacheService.getPosts(with: self.sorting.sortDescriptor)
			} catch {
				coordinator.presentErrorAlert(with: error)
			}
		}
	}

	private var posts: [PostEntity]
}
