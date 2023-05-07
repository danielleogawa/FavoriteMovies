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
    
    lazy var scrollContentView: UIView = {
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
    
    lazy var contentView: UIView = {
        let element = UIView()
//        element.backgroundColor = .red
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var contentViewGradientBackground: CAGradientLayer = {
        let element = CAGradientLayer()
        element.type = .axial
        element.colors = [
            UIColor.clear.cgColor,
            Colors.darkGray.cgColor
        ]
        element.locations = [0, 0.07]
        return element
    }()
    
    init(delegate: MovieDetailViewModelProtocol?) {
        super.init(frame: .zero)
        self.screenDelegate = delegate
        setScrollView()
        setPosterImage()
        setImages()
        setContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBackground( ){
        self.gradientBackground.frame = bounds
        layer.insertSublayer(gradientBackground, at: 0)
        self.contentViewGradientBackground.frame = contentView.bounds
        contentView.layer.addSublayer(contentViewGradientBackground)
    }
    

    private func setScrollView() {
        addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: widthAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollContentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            scrollContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContentView.heightAnchor.constraint(equalToConstant: 1700)
        ])
    }
    
    private func setPosterImage(){
        scrollContentView.addSubview(posterImage)
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: scrollContentView.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
            posterImage.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    private func setContentView() {
        scrollContentView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: -100),
            contentView.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor)
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
