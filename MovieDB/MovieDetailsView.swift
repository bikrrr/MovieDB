//
//  MovieDetailsView.swift
//  MovieDB
//
//  Created by Uhl Albert on 12/15/23.
//

import SwiftData
import SwiftUI

struct MovieDetailsView: View {
    @Bindable var movie: Movie

    var body: some View {
        Text(movie.name)
            .font(.title)
        Text(movie.director)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Movie.self, configurations: config)

    return MovieDetailsView(movie: SampleData.movies[0])
        .modelContainer(container)
}
