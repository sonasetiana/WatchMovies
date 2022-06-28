//
//  WatchMoviesApp.swift
//  WatchMovies
//
//  Created by sona setiana on 29/06/22.
//

import SwiftUI

@main
struct WatchMoviesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
