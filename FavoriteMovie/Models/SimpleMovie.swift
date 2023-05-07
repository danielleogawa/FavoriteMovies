//
//  Movie.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/04/16.
//

import Foundation

struct SimpleMovie: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Double]?
    let id: Double?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Double?
}
