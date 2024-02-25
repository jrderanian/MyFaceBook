//
//  User.swift
//  MyFaceBook
//
//  Created by John Deranian on 2/16/24.
//


//
//  User.swift
//  FriendFace
//
//  Created by John Deranian on 2/15/24.
//

import Foundation
import SwiftData
@Model
class User: Codable {
    enum CodingKeys: CodingKey {
        case id, isActive, name, age, company, email, address, about, registered, friends, tags
        
    }
    
    @Attribute(.unique) var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date?
    var unwrappedRegistered: Date {
        if let registered = registered {
            return registered
        }
        return .now
    }
    var friends: [Friend]
    var tags: [String]
    var registeredDate: Date
    
    //    var registeredDate: Date { // Computed property to convert to Date
    //        // MARK: Finally found the datetimestamp format
    //        //"2014-07-05T04:25:04-01:00"
    //
    //   // https://developer.apple.com/documentation/foundation/dateformatter
    //        let RFC3339DateFormatter = DateFormatter()
    //        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
    //        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    //        RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    //
    //
    //        if let registered = registered {
    //            let date = RFC3339DateFormatter.date(from: registered)
    //            //let date = formatter.date(from: registered)
    //            if let date = date {
    //                return date
    //            }
    //        }
    //        let _ = print("\(registered!)")
    //        return .now
    //
    //
    //
    //    }
    
    init(id: UUID, isActive: Bool, name: String, age: Int, company: String, email: String, address: String, about: String, registered: Date, friends: [Friend], tags: [String], registeredDate: Date) {
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.registered = registered
        self.friends = friends
        self.tags = tags
        self.registeredDate = registeredDate
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)
        company = try container.decode(String.self, forKey: .company)
        email = try container.decode(String.self, forKey: .email)
        address = try container.decode(String.self, forKey: .address)
        about = try container.decode(String.self, forKey: .about)
        // MARK: Using special date formatter to extract date
        registered = try container.decodeDate(forKey: .registered, withPossible: [.iso8601Full, .yyyyMMdd])
        friends = try container.decode([Friend].self, forKey: .friends)
        tags = try container.decode([String].self, forKey: .tags)
        
        registeredDate = .now
        
        
        
        
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container =  encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(company, forKey: .company)
        try container.encode(email, forKey: .email)
        try container.encode(address, forKey: .address)
        try container.encode(about, forKey: .about)
        try container.encode(registered, forKey: .registered)
        try container.encode(friends, forKey: .friends)
        try container.encode(tags, forKey: .tags)
    }
    
}



