//
//  List.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/04/16.
//

import Foundation

struct List: Codable {
    let page: Double?
    let results: [Movie]?
    let totalPages: Double?
    let totalResults: Double?
}
