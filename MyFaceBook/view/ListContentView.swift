//
//  ListContentView.swift
//  MyFaceBook
//
//  Created by John Deranian on 2/19/24.
//

import SwiftData
import SwiftUI

struct ListContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query var users: [User]
       
    @State private var path = NavigationPath()
    
    init(sortOrder: [SortDescriptor<User>] ) {
        _users = Query(sort: sortOrder)
    }
    
        var body: some View {
            NavigationStack(path: $path) {
                ScrollView {
                    VStack {
                        ForEach(users) { user in
                            NavigationLink(value: user) {
                                Text("\(user.name)")
                            }
                           
                        }
                        
                    }
                    .padding()
                    .navigationTitle("MyFaceBook")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationDestination(for: User.self) { user in
                        UserDetailView(user: user, path: $path)
                    }
                    
                }
            }
            .task {
                await loadMessages()
            }
        }
    
    func loadMessages() async {
        
        do {
            // Only re read json file if datdabase is empty
            // would be cool if there was some kind of version on the json file to know if it needed to be updated :)
            //try? modelContext.delete(model: User.self)
            if users.isEmpty {
                let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
                let (data, _) = try await URLSession.shared.data(from: url)
                var users = [User]()
                users = try JSONDecoder().decode([User].self, from: data)
                for user in users {
                    //user.registeredDate = updateRegisteredDate(for: user.registered)
                    //let _ = print("\(user.name)")
                    modelContext.insert(user)
                }
                try modelContext.save()
                
            }
            
        } catch {
            //let _ = print("Failed to load url.")
            let _ = print("Download error: \(error)")
            
        }
    }
    
}

//#Preview {
//    ListContentView()
//}
