//
//  URLSessionDecoder.swift
//  MyFaceBook
//
//  Created by John Deranian on 2/16/24.
//

import Foundation

extension URLSession {
    // iso8601 does not work with date format in json file
    func decode<T: Decodable>(
        _ type: T.Type = T.self,
        from url: URL,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .deferredToData,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601
        //https://stackoverflow.com/questions/44682626/swifts-jsondecoder-with-multiple-date-formats-in-a-json-string
    ) async throws  -> T {
        let (data, _) = try await data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        decoder.dataDecodingStrategy = dataDecodingStrategy
        decoder.dateDecodingStrategy = dateDecodingStrategy
        let decoded = try decoder.decode(T.self, from: data)
        return decoded
    }
}

//https://stackoverflow.com/questions/44682626/swifts-jsondecoder-with-multiple-date-formats-in-a-json-string
//https://stackoverflow.com/a/70304185/20065878
extension JSONDecoder.DateDecodingStrategy {
  static func anyFormatter(in formatters: [DateFormatter]) -> Self {
    return .custom { decoder in
      guard formatters.count > 0 else {
        throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "No date formatter provided"))
      }
      
      guard let dateString = try? decoder.singleValueContainer().decode(String.self) else {
        throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Could not decode date string"))
      }
      
      let successfullyFormattedDates = formatters.lazy.compactMap { $0.date(from: dateString) }
      guard let date = successfullyFormattedDates.first else {
        throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Date string \"\(dateString)\" does not match any of the expected formats (\(formatters.compactMap(\.dateFormat).joined(separator: " or ")))"))
      }
      
      return date
    }
  }
}

extension KeyedDecodingContainer {
    func decodeDate(forKey key: KeyedDecodingContainer<K>.Key, withPossible formats: [DateFormatter]) throws -> Date? {
        
        for format in formats {
            if let date = format.date(from: try self.decode(String.self, forKey: key)) {
                return date
            }
        }
        throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "Date string does not match format expected by formatter.")
    }
}

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
        
