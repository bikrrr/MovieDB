//
//  MovieListView.swift
//  MovieDB
//
//  Created by Uhl Albert on 12/15/23.
//

import SwiftData
import SwiftUI

struct MovieListView: View {
    @Environment(\.modelContext) var modelContext
    @Query var movies: [Movie]

    init(searchString: String = "", sortOrder: [SortDescriptor<Movie>] = []) {
        _movies = Query(filter: #Predicate { movie in
            if searchString.isEmpty {
                true
            } else {
                movie.name.localizedStandardContains(searchString)
            }
        }, sort: [SortDescriptor(\Movie.name)])
    }

    var body: some View {
        List {
            ForEach(movies) { movie in
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
    }

    func deleteMovies(_ offsets: IndexSet) {
        for offset in offsets {
            let movie = movies[offset]
            modelContext.delete(movie)
        }
    }
}

#Preview {
    MovieListView()
}
