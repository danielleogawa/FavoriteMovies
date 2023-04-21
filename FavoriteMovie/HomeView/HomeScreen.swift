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
    
    lazy var mainCollectionView: UICollectionView = {
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
        element.register(HomeMovieCollectionViewCell.self, forCellWithReuseIdentifier: HomeMovieCollectionViewCell.identifier)
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionView()
        setScrollView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBackground( ){
        self.gradientBackground.frame = bounds
        layer.insertSublayer(gradientBackground, at: 0)
    }
    
    func setDelegate(delegate: Delegate) {
        self.mainCollectionView.delegate = delegate
        self.mainCollectionView.dataSource = delegate
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
    
    
    
    func setCollectionView() {
        contentView.addSubview(mainCollectionView)
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainCollectionView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
}

