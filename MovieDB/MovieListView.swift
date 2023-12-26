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
    @Query(sort: [SortDescriptor(\Movie.name, order: .forward), SortDescriptor(\Movie.director)]) var movies: [Movie]

    init(sort: SortDescriptor<Movie>, searchString: String = "") {
        _movies = Query(
            filter: #Predicate {
                searchString.isEmpty || $0.name.contains(searchString)
            },
            sort: [sort]
        )
    }

    var body: some View {
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

    func deleteMovies(_ indexSet: IndexSet) {
        for index in indexSet {
            let movie = movies[index]
            modelContext.delete(movie)
        }
    }
}

#Preview {
    MovieListView(sort: SortDescriptor(\.name))
}
