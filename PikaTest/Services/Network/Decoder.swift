//
//  DecoderProtocol.swift
//  PikaTest
//
//  Created by Alexander Bochkarev on 10.12.2019.
//  Copyright © 2019 Александр Бочкарев. All rights reserved.
//

import Foundation

/// Decoder protocol
protocol DecoderProtocol {

	/// A property for storing some additional info
	var userInfo: [CodingUserInfoKey : Any] { get }

	/// Decode given data to desired type which conforms to Decodable protocol
	/// - Parameters:
	///   - type: type of result object being decoded
	///   - data: data to decode
	func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

/// Extend JSON Decoder for general decoder protocol
extension JSONDecoder: DecoderProtocol {
    
}
