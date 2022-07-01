//
//  WatchMoviesApp.swift
//  WatchMovies
//
//  Created by sona setiana on 29/06/22.
//

import SwiftUI

@main
struct WatchMoviesApp: App {

    var body: some Scene {
        WindowGroup {
            AppModules.shared.provideHomeView()
        }
    }
}
