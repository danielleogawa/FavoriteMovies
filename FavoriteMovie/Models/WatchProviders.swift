//
//  WatchProviders.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/05/22.
//

import Foundation

struct MovieWatchProviders: Codable {
    let id: Double?
    let results: Country?
    
    struct Country: Codable {
        let US: WatchProviders?
    }

    struct WatchProviders: Codable {
        let link: String?
        let rent: [WatchProvider]?
    }
   
    struct WatchProvider: Codable {
        let providerId: Double
        let providerName: String?
        let logoPath: String?
        let displayPriority: Double?
        let providerType: String?
    }
}
