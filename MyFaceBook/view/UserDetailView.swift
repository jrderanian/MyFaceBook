//
//  UserDetailView.swift
//  MyFaceBook
//
//  Created by John Deranian on 2/23/24.
//

import SwiftData
import SwiftUI

struct UserDetailView: View {
    
    var user: User
    @Query var users: [User]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        
        Form {
            
            Section("Details") {
                Text("\(user.name)")
                Text("\(user.email)")
                Text(user.isActive ? "Active" : "Not Active")
                Text("\(user.age)")
                Text("\(user.company)")
                Text("\(user.address)")
                Text("\(user.about)")
                Text(user.unwrappedRegistered, style: .date)
            }
            
            Section("Friends") {
                ForEach(user.friends) { friend in
                    ForEach(users) {user in
                        if user.id == friend.id {
                            NavigationLink(value: user) {
                                Text("\(user.name)")
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

//#Preview {
//    UserDetailView()
//}
