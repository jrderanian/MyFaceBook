//
//  URLSessionDecoder.swift
//  MyFaceBook
//
//  Created by John Deranian on 2/16/24.
//

import Foundation

extension URLSession {
    func decode<T: Decodable>(
        _ type: T.Type = T.self,
        from url: URL,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .deferredToData,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601
        
    ) async throws  -> T {
        let (data, _) = try await data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        decoder.dataDecodingStrategy = dataDecodingStrategy
        
        decoder.dateDecodingStrategy = dateDecodingStrategy
//        let formatter = ISO8601DateFormatter()
//        //2014-07-05T04:25:04-01:00
//        formatter.formatOptions = [.withFullDate, .withFullTime, .withColonSeparatorInTimeZone, .withTimeZone]
        
//        decoder.dateDecodingStrategy = .custom({ decoder in
//            
//            let formatter = ISO8601DateFormatter()
//            //2014-07-05T04:25:04-01:00
//            formatter.formatOptions = [.withFullDate, .withFullTime, .withColonSeparatorInTimeZone, .withTimeZone]
//            
//            // pull out the number of days from Codable
//            let container = try decoder.singleValueContainer()
//            let dateString = try container.decode(Date.self)
//            
//            if let date = formatter.date(from: dateString) {
//                return date
//            }
//            
//            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
//            
//        })

        let decoded = try decoder.decode(T.self, from: data)
        return decoded
    }
}
