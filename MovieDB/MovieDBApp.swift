//
//  MovieDBApp.swift
//  MovieDB
//
//  Created by Uhl Albert on 12/13/23.
//

import SwiftData
import SwiftUI

@main
struct MovieDBApp: App {
    let container: ModelContainer

    var body: some Scene {
        WindowGroup {
            ContentView(modelContext: container.mainContext)
        }
        .modelContainer(container)
    }

    init() {
        do {
            container = try ModelContainer(for: Movie.self)
        } catch {
            fatalError("Failed to create ModelContainer for Movie.")
        }
    }
}
