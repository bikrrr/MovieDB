//
//  PreviewContainer.swift
//  MovieDB
//
//  Created by Uhl Albert on 12/14/23.
//

import Foundation
import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(
            for: Movie.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )

        SampleData.movies.forEach { movie in
            container.mainContext.insert(movie)
        }

        return container
    } catch {
        fatalError("Failed to create container.")
    }
}()

struct SampleData {
    static let movies: [Movie] = {
        return [
            Movie(name: "The Iron Giant", director: "Brad Bird", releaseYear: 1999),
            Movie(name: "The Revenant", director: "Alejandro G. Iñárritu", releaseYear: 2015),
            Movie(name: "Rosemary's Baby", director: "Roman Polanski", releaseYear: 1968)
        ]
    }()
}
