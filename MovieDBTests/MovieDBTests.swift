//
//  MovieDBTests.swift
//  MovieDBTests
//
//  Created by Uhl Albert on 1/18/24.
//

import SwiftData
import XCTest
@testable import MovieDB

protocol ViewModelTestable {
    init(modelContext: ModelContext)
}

extension ContentView.ViewModel: ViewModelTestable { }

@MainActor
final class MovieDBTests: XCTestCase {

    func make<T: ViewModelTestable>(viewModel: T.Type) throws -> T {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Movie.self, configurations: config)
        return T(modelContext: container.mainContext)
    }

    func testAppStartsEmpty() throws {
        // Given
        let sut = try make(viewModel: ContentView.ViewModel.self)

        // Then
        XCTAssertEqual(sut.movies.count, 0, "There should be 0 movies when the app is first launched.")
    }

    func testCreatingSamplesWorks() throws {
        // Given
        let sut = try make(viewModel: ContentView.ViewModel.self)

        // When
        sut.addSamples()

        // Then
        XCTAssertEqual(sut.movies.count, 3, "There should be 3 movies after adding sample data.")
    }

    func testCreatingAndClearingLeavesAppEmpty() throws {
        // Given
        let sut = try make(viewModel: ContentView.ViewModel.self)

        // When
        sut.addSamples()
        sut.clear()

        // Then
        XCTAssertEqual(sut.movies.count, 0, "There should be 0 movies after deleting all data.")
    }

}
