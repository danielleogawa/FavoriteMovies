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
    var average: Double? = nil
    
    func getName() -> String {
        guard let name else { return "" }
        return name
    }
    
    func getAverage() -> String {
        guard let average else {
            return ""
        }
        return String(format: "%.2f", average)
    }
}
