//
//  MovieModel.swift
//  MovieDB
//
//  Created by Uhl Albert on 12/13/23.
//

import Foundation
import SwiftData

@Model
final class Movie {
  var name: String
  var director: String
  var releaseYear: Int

  init(name: String, director: String, releaseYear: Int) {
      self.name = name
      self.director = director
      self.releaseYear = releaseYear
  }
}
