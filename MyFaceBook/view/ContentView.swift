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
    //@Query var users: [User]
    @Query(filter: #Predicate<User> { user in
        user.name.contains("R")
    }, sort: \User.registeredDate, order: .reverse) var users: [User]
  
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("Boo")
                    ForEach(users) { user in
                        HStack {
                            Text("\(user.name)")
                            Text("\(user.registeredDate.formatted(date: .abbreviated, time: .omitted))")
                        }
                    }
                    
                }
                .padding()
                .navigationTitle("Boo")
                .task {
                    await loadMessages()
                }
            }
        }
    }
    
    func loadMessages() async {
        
        do {
            try? modelContext.delete(model: User.self)
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            var users = [User]()
            users = try JSONDecoder().decode([User].self, from: data)
            for user in users {
                user.registeredDate = updateRegisteredDate(for: user.registered)
                modelContext.insert(user)
            }
            
        } catch {
            //let _ = print("Failed to load url.")
            let _ = print("Download error: \(error)")
            
        }
    }
    
    
    func loadJSON() async {
        
        //        let url1 = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        //        let user = try await URLSession.shared.decode(User.self, from: url1)
        //
        
        
        do {
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            //let users = try await URLSession.shared.decode(User.self, from: url)
            let (data, _) = try await URLSession.shared.data(from: url)
            let users = try JSONDecoder().decode([User].self, from: data)
            
            let _ = print("\(users.count)")
            let _ = print("here")
            
            for user in users {
                let _ = print("\(user.name)")
                modelContext.insert(user)
            }
        } catch {
            let _ = print("Failed to load url.")
        }
        
    }
    
    
    func updateRegisteredDate(for stringDate: String) -> Date {
        
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        if let date = RFC3339DateFormatter.date(from: stringDate) {
            return date
        }
           
        return .now
    }
}

#Preview {
    ContentView()
}
