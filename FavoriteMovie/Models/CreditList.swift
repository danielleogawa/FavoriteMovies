//
//  Cast.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/05/16.
//

import Foundation

struct CreditList: Codable {
    let id: Double?
    let cast: [Cast]?
    let crew: [Crew]?
}

struct Cast: Codable {
    let adult: Bool?
    let gender: Double?
    let id: Double?
    let knownForDepartment: String?
    let name: String?
    let originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castId: Double?
    let character: String?
    let creditId: String?
    let order: Double?
}

struct Crew: Codable {
    let adult: Bool?
    let gender: Double?
    let id: Double?
    let knownForDepartment: String?
    let name: String?
    let originalName: String?
    let popularity: Double?
    let profilePath: String?
    let creditId: String?
    let department: String?
    let job: String?
}
