//
//  MyFaceBookApp.swift
//  MyFaceBook
//
//  Created by John Deranian on 2/16/24.
//

import SwiftUI
import SwiftData

@main
struct MyFaceBookApp: App {
    var container: ModelContainer
    
    init() {
        do {
            let storeURL = URL.documentsDirectory.appending(path: "myfacbook_v4.sqlite")
            let config = ModelConfiguration(url: storeURL)
            container = try ModelContainer(for: User.self, configurations: config)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
