//
//  OnTheatresTableViewCell.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/04/20.
//

import UIKit


class OnTheatresTableViewCell: UITableViewCell {

    static let identifier = "onTheatresTableViewCell"
    
    lazy var content: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var collectionView: UICollectionView = {
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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        setBackgroundView()
        setCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setBackgroundView() {
        addSubview(content)
        
        NSLayoutConstraint.activate([
            content.widthAnchor.constraint(equalTo: self.widthAnchor),
            content.topAnchor.constraint(equalTo: self.topAnchor),
            content.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            content.heightAnchor.constraint(equalToConstant: 600),
        ])
    }
    
    private func setCollectionView() {
        content.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: content.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    func setDelegate(delegate: UICollectionViewDelegate & UICollectionViewDataSource) {
        self.collectionView.delegate = delegate
        self.collectionView.dataSource = delegate
    }
    
}
