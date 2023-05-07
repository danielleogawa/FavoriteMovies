//
//  MovieDetailScreen.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/05/01.
//

import UIKit

final class MovieDetailScreen: UIView {
    
    private var screenDelegate: MovieDetailViewModelProtocol?

    lazy var gradientBackground: CAGradientLayer = {
        let element = CAGradientLayer()
        element.type = .axial
        element.colors = [
            Colors.darkMagenta.cgColor,
            Colors.darkGray.cgColor
        ]
        element.locations = [0, 1]
        return element
    }()
    
    lazy var contentView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var scrollView: UIScrollView = {
        let element = UIScrollView()
        element.contentInsetAdjustmentBehavior = .always
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    lazy var posterImage: UIImageView = {
        var element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFill
        element.backgroundColor = .gray
        return element
    }()
    
    lazy var favoriteButton: UIButton = {
        let element = UIButton()
        element.setImage(UIImage(systemName: "heart"), for: .normal)
        element.addTarget(self, action: #selector(self.favoriteButtonTapped), for: .touchUpInside)
        return element
    }()
    
    init(delegate: MovieDetailViewModelProtocol?) {
        super.init(frame: .zero)
        self.screenDelegate = delegate
        setScrollView()
        setPosterImage()
        setImages()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBackground( ){
        self.gradientBackground.frame = bounds
        layer.insertSublayer(gradientBackground, at: 0)
    }
    

    private func setScrollView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: widthAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1700)
        ])
    }
    
    private func setPosterImage(){
        contentView.addSubview(posterImage)
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImage.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    func setImages() {
        screenDelegate?.getPosterImage(completion: { image in
            self.posterImage.image = image
        })
    }
    
    
    func setNavigationController(viewController: UIViewController) {
        viewController.navigationItem.title = screenDelegate?.getMovieTitle()
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteButton)
    }
    
    @objc func favoriteButtonTapped() {
        print("favoritou")
    }
    
}
