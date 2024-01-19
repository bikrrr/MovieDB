//
//  MovieDBTests.swift
//  MovieDBTests
//
//  Created by Uhl Albert on 1/18/24.
//

import SwiftData
import XCTest
@testable import MovieDB

@MainActor
final class MovieDBTests: XCTestCase {

    func testAppStartsEmpty() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Movie.self, configurations: config)

        let sut = ContentView.ViewModel(modelContext: container.mainContext)

        XCTAssertEqual(sut.movies.count, 0, "There should be 0 movies when the app is first launched.")
    }

    func testCreatingSamplesWorks() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Movie.self, configurations: config)

        let sut = ContentView.ViewModel(modelContext: container.mainContext)
        sut.addSamples()

        XCTAssertEqual(sut.movies.count, 3, "There should be 3 movies after adding sample data.")
    }

    func testCreatingAndClearingLeavesAppEmpty() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Movie.self, configurations: config)

        let sut = ContentView.ViewModel(modelContext: container.mainContext)
        sut.addSamples()
        sut.clear()

        XCTAssertEqual(sut.movies.count, 0, "There should be 0 movies after deleting all data.")
    }

}
