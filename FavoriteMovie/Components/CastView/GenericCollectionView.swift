//
//  CastCollectionView.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/05/18.
//

import UIKit

class GenericCollectionView: UIView {

    var viewModel: GenericCollectionViewViewModel?
    var imageHeight: Int
    var width: Int
    var hasBottomInfo: Bool
    
    lazy var collectionView: UICollectionView = {
        let element = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        element.translatesAutoresizingMaskIntoConstraints = false
        element.showsHorizontalScrollIndicator = false
        element.backgroundColor = .clear
        element.delaysContentTouches = false
        element.isPagingEnabled = true
        element.contentInsetAdjustmentBehavior = .never
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: width, height: imageHeight + 30)
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal
        element.setCollectionViewLayout(layout, animated: true)
        return element
    }()
    
    lazy var collectionViewTitle: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = viewModel?.collectionViewTitle
        element.numberOfLines = 0
        element.textColor = .white
        element.font = .boldSystemFont(ofSize: 14)
        return element
    }()
    

    init(viewModel: GenericCollectionViewViewModel?, collectionViewHeight: Int, width: Int = 100, hasBottomInfo: Bool) {
        self.viewModel = viewModel
        self.width = width
        self.imageHeight = collectionViewHeight
        self.hasBottomInfo = hasBottomInfo
        super.init(frame: .zero)
        backgroundColor = Colors.darkMagenta
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GenericCollectionViewCell.self, forCellWithReuseIdentifier: GenericCollectionViewCell.identifier)
        setCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCollectionView() {
        addSubview(collectionViewTitle)
        NSLayoutConstraint.activate([
            collectionViewTitle.topAnchor.constraint(equalTo:  self.topAnchor, constant: 8),
            collectionViewTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            collectionViewTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: collectionViewTitle.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
    func updateViewModel(with persons: [Item]) {
        self.viewModel?.items = persons
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}


extension GenericCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.layoutIfNeeded()
        return viewModel?.getNumberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenericCollectionViewCell.identifier, for: indexPath) as? GenericCollectionViewCell {
            viewModel?.getPerson(row: indexPath.row, completion: { viewModel in
                cell.updateViewModel(viewModel, imageHeight: self.imageHeight, hasBottomInfo: self.hasBottomInfo)
                cell.layoutIfNeeded()
            })
            collectionView.layoutIfNeeded()
            return cell
        }
        return UICollectionViewCell()
    }
}
