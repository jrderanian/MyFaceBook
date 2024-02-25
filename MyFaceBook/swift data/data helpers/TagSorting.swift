//
//  TagSorting.swift
//  MyFaceBook
//
//  Created by John Deranian on 2/18/24.
//

import Foundation

enum TagSorting: String, Identifiable, CaseIterable {
    case aToZ
    case zToA
    case oldest
    case newest
    
    var title: String {
        switch self {
            case .aToZ:
                return "Name A to Z"
        case .zToA:
            return "Name Z to A"
            
            case .oldest:
                return "Oldest Members"
        case .newest:
            return "Newest Members"
        }
    }
    
    var sortDescriptor: [SortDescriptor<User>] {
        switch self {
        case .aToZ:
            [
                SortDescriptor(\User.name),
                SortDescriptor(\User.registered)
            ]
        case .zToA:
            [
                SortDescriptor(\User.name, order: .reverse),
                SortDescriptor(\User.registered)
            ]
        case .oldest:
            
            [
                SortDescriptor(\User.registered, order: .reverse),
                SortDescriptor(\User.name)
            ]
            
        case .newest:
            [
                SortDescriptor(\User.registered),
                SortDescriptor(\User.name)
            ]
        }
    }
    
    var id: Self { return self }
}
