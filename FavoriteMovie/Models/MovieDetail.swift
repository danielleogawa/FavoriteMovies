//
//  MovieDetail.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/05/07.
//

import Foundation

struct ProductionCompanies: Codable {
    let id: Double
    let logoPath: String?
    let name: String?
    let originCountry: String?
}


struct MovieDetail: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genres: [Genre]?
    let homepage: String?
    let imdbId: String?
    let productionCompanies: [ProductionCompanies]?
    let runtime: Double?
    let status: String?
    let tagline: String?
    let title: String?
}
