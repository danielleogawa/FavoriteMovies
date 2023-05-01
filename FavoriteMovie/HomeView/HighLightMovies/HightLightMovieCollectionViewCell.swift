//
//  HightLightMovieCollectionViewCell.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/05/01.
//

import UIKit

class HightLightMovieCollectionViewCell: UICollectionViewCell {
    static let identifier = "HightLightMovieCollectionViewCell"
    
    lazy var posterImage: UIImageView = {
        var element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFill
        element.clipsToBounds = true
        element.layer.cornerRadius = 20
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setPosterImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPosterImage(){
        contentView.addSubview(posterImage)
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
        ])
    }
    
    func setCell(image: UIImage) {
        posterImage.image = image
    }
}
