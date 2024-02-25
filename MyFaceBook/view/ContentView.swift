//
//  ContentView.swift
//  MyFaceBook
//
//  Created by John Deranian on 2/16/24.
//

//
//  ContentView.swift
//  FriendFace
//
//  Created by John Deranian on 2/15/24.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State var tagSorting = TagSorting.aToZ
    
    var body: some View {
        @Environment(\.modelContext) var modelContext
        ListContentView(sortOrder: tagSorting.sortDescriptor)
    }
    
    
    
    
//    func loadJSON() async {
//        
//        //        let url1 = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
//        //        let user = try await URLSession.shared.decode(User.self, from: url1)
//        //
//        
//        
//        do {
//            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
//            //let users = try await URLSession.shared.decode(User.self, from: url)
//            let (data, _) = try await URLSession.shared.data(from: url)
//            let users = try JSONDecoder().decode([User].self, from: data)
//            
//            let _ = print("\(users.count)")
//            let _ = print("here")
//            
//            for user in users {
//                let _ = print("\(user.name)")
//                modelContext.insert(user)
//            }
//        } catch {
//            let _ = print("Failed to load url.")
//        }
//        
//    }
//    
//    
//    func updateRegisteredDate(for stringDate: String) -> Date {
//        
//        let RFC3339DateFormatter = DateFormatter()
//        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
//        RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
//
//        if let date = RFC3339DateFormatter.date(from: stringDate) {
//            return date
//        }
//           
//        return .distantPast
//    }
}

#Preview {
    ContentView()
}
