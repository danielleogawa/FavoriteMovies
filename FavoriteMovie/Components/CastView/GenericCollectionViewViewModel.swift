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
    
    func getPerson(row: Int, completion: @escaping (GenericCollectionViewCellViewModel) -> Void) {
        guard let item = items?[row],
                let profilePath = item.imagePath,
                let url = Request.getImageURL(posterPath: profilePath) else {
            return
        }
        Request.downloadImage(from: url) { downloadedImage, _ in
            completion(GenericCollectionViewCellViewModel(image: downloadedImage, name: item.name))
        }
    }
}


