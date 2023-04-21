//
//  Genre.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/04/21.
//

import Foundation

struct GenreList: Codable {
    let genres: [Genre]?
}

struct Genre: Codable {
    let id: Int?
    let name: String?
}

