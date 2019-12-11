//
//  DecoderProtocol.swift
//  PikaTest
//
//  Created by Alexander Bochkarev on 10.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import Foundation


protocol DecoderProtocol {

	var userInfo: [CodingUserInfoKey : Any] { get }

	func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

extension JSONDecoder: DecoderProtocol {

}
