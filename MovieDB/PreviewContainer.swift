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

        return container
    } catch {
        fatalError("Failed to create container.")
    }
}()
