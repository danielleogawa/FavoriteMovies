//
//  Item.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/05/21.
//

import UIKit
class Item {
    //casts
    let imagePath: String?
    var image: UIImage?
    let name: String?
    var caracter: String? = nil
    
    //movies
    var id: Double? = nil
    var popularity: Double? = nil
    
    init(imagePath: String?,
         image: UIImage? = nil,
         name: String?,
         caracter: String? = nil,
         id: Double? = nil,
         popularity: Double? = nil
    ) {
        self.imagePath = imagePath
        self.image = image
        self.name = name
        self.caracter = caracter
        self.id = id
        self.popularity = popularity
        loadImage()
    }
    
    func loadImage() {
        guard let imagePath, let url = Request.getImageURL(posterPath: imagePath) else { return }
        Request().downloadImage(from: url) { downloadedImage, _ in
            self.image = downloadedImage
        }
    }
}
