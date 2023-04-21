//
//  HomeScreen.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/04/16.
//

import UIKit

final class HomeScreen: UIView {
    
    typealias Delegate = UICollectionViewDataSource & UICollectionViewDelegate
    
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
//        element.backgroundColor = .blue
        return element
    }()
    
    lazy var scrollView: UIScrollView = {
        let element = UIScrollView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var onTheatresCollectionView: UICollectionView = {
        let element = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        element.translatesAutoresizingMaskIntoConstraints = false
        element.showsHorizontalScrollIndicator = false
        element.backgroundColor = .clear
        element.delaysContentTouches = false
        element.isPagingEnabled = true
        element.contentInsetAdjustmentBehavior = .never
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        element.setCollectionViewLayout(layout, animated: true)
        element.tag = 1
        return element
    }()
    
    lazy var genresCollectionView: UICollectionView = {
        let element = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        element.translatesAutoresizingMaskIntoConstraints = false
        element.showsHorizontalScrollIndicator = false
        element.backgroundColor = .clear
        element.delaysContentTouches = false

        element.contentInsetAdjustmentBehavior = .never
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal
        element.setCollectionViewLayout(layout, animated: true)
        element.tag = 2
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setScrollView()
        setOnTheatresCollectionViewCollectionView()
        setGenresCollectionViewCollectionView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBackground( ){
        self.gradientBackground.frame = bounds
        layer.insertSublayer(gradientBackground, at: 0)
    }
    
    func setDelegate(delegate: Delegate) {
        self.onTheatresCollectionView.delegate = delegate
        self.onTheatresCollectionView.dataSource = delegate
        self.onTheatresCollectionView.register(HomeMovieCollectionViewCell.self, forCellWithReuseIdentifier: HomeMovieCollectionViewCell.identifier)
    }
    
    func setDelegateGener(delegate: Delegate) {
        self.genresCollectionView.delegate = delegate
        self.genresCollectionView.dataSource = delegate
        self.genresCollectionView.register(GenresCollectionViewCell.self, forCellWithReuseIdentifier: GenresCollectionViewCell.identifier)
    }
    
    func setScrollView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     scrollView.widthAnchor.constraint(equalTo: widthAnchor),
                                     scrollView.topAnchor.constraint(equalTo: topAnchor),
                                     scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     
                                     contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                                     contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                                     contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                                     contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                                     contentView.heightAnchor.constraint(equalToConstant: 1000),
                                    ])
    }
    
    
    
    func setOnTheatresCollectionViewCollectionView() {
        contentView.addSubview(onTheatresCollectionView)
        NSLayoutConstraint.activate([
            onTheatresCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            onTheatresCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            onTheatresCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            onTheatresCollectionView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    func setGenresCollectionViewCollectionView() {
        contentView.addSubview(genresCollectionView)
        NSLayoutConstraint.activate([
            genresCollectionView.topAnchor.constraint(equalTo: onTheatresCollectionView.bottomAnchor),
            genresCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            genresCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            genresCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

