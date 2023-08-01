//
//  CastCollectionViewViewModel.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/05/18.
//

import Foundation
import UIKit

struct GenericCollectionViewViewModel {
    var collectionViewTitle: String
    var items: [Item]?
    
    init(collectionViewTitle: String, items: [Item]?) {
        self.collectionViewTitle = collectionViewTitle
        self.items = items
    }
    
    func getNumberOfItems() -> Int {
        items?.count ?? 0
    }
    
    func getPerson(row: Int) -> GenericCollectionViewCellViewModel? {
        guard let item = items?[row] else { return nil }
        return GenericCollectionViewCellViewModel(image: item.image, name: item.name, average: item.popularity)
    }
}


