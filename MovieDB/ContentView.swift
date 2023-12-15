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
    @State private var searchText = ""

    var body: some View {
        NavigationStack(path: $navPath) {
            List {
                MovieListView(sort: sortOrder, searchString: searchText)
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
        let redOctober = Movie(name: "The Hunt for Red October", director: "John McTiernan", releaseYear: 1990)
        let sneakers = Movie(name: "Sneakers", director: "Phil Alden Robinson", releaseYear: 1992)
        let endLiss = Movie(name: "Endliss Possibilities: The Casey Liss Story", director: "Erin Liss", releaseYear: 2006)

        modelContext.insert(redOctober)
        modelContext.insert(sneakers)
        modelContext.insert(endLiss)
        try? modelContext.save()
    }

    func clear() {
        try? modelContext.delete(model: Movie.self)
        try? modelContext.save()
    }
}

struct ContentView_Previews: PreviewProvider {
   static var sampleModelContext: ModelContext? {
       // Create a Schema (replace this with actual Schema creation)
       let sampleSchema = Schema() // Replace with actual Schema creation

       do {
           let sampleModelContainer = try ModelContainer(for: sampleSchema)
           return ModelContext(sampleModelContainer)
       } catch {
           // Log error or handle it as needed
           print("Error initializing ModelContainer: \(error)")
           return nil
       }
   }

   static var previews: some View {
       if sampleModelContext != nil {
           ContentView()
       } else {
           // Provide an alternative view in case of initialization failure
           Text("Error initializing ModelContext")
       }
   }
}

#Preview {
    return ContentView()
        .modelContainer(previewContainer)
}
