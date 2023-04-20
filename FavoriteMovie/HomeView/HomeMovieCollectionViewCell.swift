//
//  HomeMovieCollectionViewCell.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/04/16.
//

import UIKit

class HomeMovieCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "HomeMovieCollectionViewCell"
    
    lazy var posterImage: UIImageView = {
        var element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .darkGray
        element.contentMode = .scaleAspectFill
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setPosterImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setPosterImage() {
        addSubview(posterImage)
        
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: self.firstBaselineAnchor),
            posterImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            posterImage.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    func setCell(with image: UIImage?, movie: Movie?) {
            self.posterImage.image = image
    }
    
}
