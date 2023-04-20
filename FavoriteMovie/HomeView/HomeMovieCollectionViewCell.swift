//
//  HomeMovieCollectionViewCell.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/04/16.
//

import UIKit

class HomeMovieCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "HomeMovieCollectionViewCell"
    
    lazy var cellContentView: UIView = {
        var element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
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
        setCellContentView()
        setPosterImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCellContentView() {
        addSubview(cellContentView)
        
        NSLayoutConstraint.activate([
            cellContentView.topAnchor.constraint(equalTo: self.firstBaselineAnchor),
            cellContentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cellContentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cellContentView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    private func setPosterImage() {
        cellContentView.addSubview(posterImage)
        
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: cellContentView.topAnchor, constant: 24),
            posterImage.leadingAnchor.constraint(equalTo: cellContentView.leadingAnchor, constant: 24),
            posterImage.trailingAnchor.constraint(equalTo: cellContentView.trailingAnchor, constant: -24),
            posterImage.bottomAnchor.constraint(equalTo: cellContentView.bottomAnchor, constant: -24)
        ])
    }
    
    func setCell(with image: UIImage?, movie: Movie?) {
            self.posterImage.image = image
    }
    
}
