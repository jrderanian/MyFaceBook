//
//  RemovingOptionals.swift
//  MyFaceBook
//
//  Created by John Deranian on 2/24/24.
//

import Foundation

protocol OptionalProtocol {
    associatedtype Wrapped
    var optional: Wrapped? { get }
}

extension Optional: OptionalProtocol {
    var optional: Wrapped? {
        return self
    }
}

extension Sequence where Element: OptionalProtocol {
    var removingOptionals: [Element.Wrapped] {
        return self.compactMap { $0.optional }
    }
}

// Usage:
//let array: [Int?] = [1, 2, nil, 3, 4, nil]
//print(array.removingOptionals) // prints [1, 2, 3, 4], has type [Int]
