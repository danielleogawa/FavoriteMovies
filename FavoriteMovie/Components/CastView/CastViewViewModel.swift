//
//  CastViewViewModel.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/05/18.
//
import UIKit

struct GenericCollectionViewCellViewModel {
    let image: UIImage?
    let name: String?
    
    func getName() -> String {
        guard let name else { return "" }
        return name
    }
}
