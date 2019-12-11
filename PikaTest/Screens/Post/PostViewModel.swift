//
//  PostViewModel.swift
//  PikaTest
//
//  Created by Александр Бочкарев on 04.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import Foundation

protocol PostViewModelProtocol: ViewModelProtocol {

	var apiService: APIServiceProtocol { get }
	var cacheService: CacheServiceProtocol { get }
	var post: PostEntity { get }

	init(coordinator: PostCoordinatorProtocol, post: PostEntity, apiService: APIServiceProtocol, cacheService: CacheServiceProtocol)

	var text: String? { get }
	var imageUrls: [URL]? { get }

	func fetchPost(completion: @escaping (_ success: Result<Bool, Error>) -> ())
}


final class PostViewModel: PostViewModelProtocol {
	typealias Coordinator = CoordinatorProtocol

	// MARK: - PostViewModelProtocol -
	
	let coordinator: CoordinatorProtocol
	let apiService: APIServiceProtocol
	let cacheService: CacheServiceProtocol
	private(set) var post: PostEntity {
		didSet {
			text = post.text
			if let postImageUrls = post.imageUrls {
				imageUrls = postImageUrls.map { URL(string: $0)! }
			}
		}
	}
	
	required init(coordinator: PostCoordinatorProtocol,
				  post: PostEntity,
				  apiService: APIServiceProtocol = APIService(),
				  cacheService: CacheServiceProtocol = CoreDataService()) {
		self.post = post
		self.coordinator = coordinator
		self.apiService = apiService
		self.cacheService = cacheService
	}

	private(set) var text: String?
	private(set) var imageUrls: [URL]?

	func fetchPost(completion: @escaping (_ success: Result<Bool, Error>) -> ()) {

		apiService.getPost(from: PostEndpoint(postId: Int(post.id))) { [weak self] result in
			DispatchQueue.main.async {
				guard let `self` = self else {
					return
				}

				switch result {
				case .success(let postResult):
					guard let post = postResult?.post else {
						return
					}

					self.post = post
					completion(.success(true))
				case .failure(let error):
					completion(.failure(error))
				}
			}
		}
	}
}
