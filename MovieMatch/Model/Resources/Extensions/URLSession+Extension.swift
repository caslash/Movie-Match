//
//  URLSession+Extension.swift
//  Holidays WatchKit Extension
//
//  Created by Cameron Slash on 07/1/22.
//

import Foundation

extension URLSession {
    func decode<T: Decodable>(
        _ type: T.Type = T.self,
        from request: URLRequest,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .deferredToData,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
    ) async throws -> T {
        let (data, _) = try await data(for: request)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        decoder.dataDecodingStrategy = dataDecodingStrategy
        decoder.dateDecodingStrategy = dateDecodingStrategy
        
        let decoded = try decoder.decode(T.self, from: data)
        return decoded
    }
}
