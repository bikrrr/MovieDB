//
//  ContentView.swift
//  MovieDB
//
//  Created by Uhl Albert on 12/13/23.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext

    @State private var navPath = [Movie]()
    @State private var sortOrder = SortDescriptor(\Movie.name)
    @State private var searchText: String = ""

    @Query(sort: [SortDescriptor(\Movie.name, order: .forward), SortDescriptor(\Movie.director)]) var movies: [Movie]

    private var filteredMovies: [Movie] {
        movies.filter { searchText.isEmpty || $0.name.contains(searchText) }
    }

    init(sort: SortDescriptor<Movie>, searchString: String = "") {
        _movies = Query(
            filter: #Predicate {
                searchString.isEmpty || $0.name.contains(searchString)
            },
            sort: [sort]
        )
    }

    var body: some View {
        NavigationStack(path: $navPath) {
            List {
                ForEach(filteredMovies) { movie in
                    NavigationLink(value: movie){
                        VStack(alignment: .leading) {
                            Text(movie.name)
                                .font(.headline)
                            Text("Directed by: \(movie.director)")
                        }
                    }
                }
                .onDelete(perform: deleteMovies)
            }
            .navigationDestination(for: Movie.self) { movie in
                MovieDetailsView(movie: movie)
            }
            .searchable(text: $searchText, prompt: "Find a movie")
            .navigationTitle("MovieDB")

            .toolbar {
                Button("Add Samples", systemImage: "plus", action: addSamples)
            }
        }
    }

    func addNewRestaurant() {
        let newMovie = Movie(name: "New Restaurant", director: "Someone", releaseYear: 1950)
        modelContext.insert(newMovie)

        navPath = [newMovie]
    }

    private func addSamples() {
        for movie in SampleData.movies {
            modelContext.insert(movie)
        }

        try? modelContext.save()
    }

    func deleteMovies(_ indexSet: IndexSet) {
        for index in indexSet {
            let movie = movies[index]
            modelContext.delete(movie)
        }
    }
}

#Preview {
    return ContentView(sort: SortDescriptor(\.name))
        .modelContainer(previewContainer)
}
