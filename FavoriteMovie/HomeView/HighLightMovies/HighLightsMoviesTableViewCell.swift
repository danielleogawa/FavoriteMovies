//
//  HighLightsMoviesTableViewCell.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/05/01.
//

import UIKit

class HighLightsMoviesTableViewCell: UITableViewCell, HightLightMoviesDelegate {
    
    static let identifier = "HighLightsMoviesTableViewCell"

    var viewModel: HightLightMoviesViewModel?
    
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
        element.tag = 3
        return element
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.viewModel = HightLightMoviesViewModel(delegate: self)
        self.backgroundColor = .clear
        collectionView.register(HightLightMovieCollectionViewCell.self, forCellWithReuseIdentifier: HightLightMovieCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        setCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCollectionView() {
        contentView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
    
    func setCellForRow(_ row: Int){
        viewModel?.setCategoryOfRow(row)
    }
    
}

extension HighLightsMoviesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.getNumberOfCollectionViewCell() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HightLightMovieCollectionViewCell.identifier, for: indexPath) as? HightLightMovieCollectionViewCell {
            
            let movie = viewModel?.getMovie(row: indexPath.row)
            
            Request.getImage(movie: movie) { image in
                cell.setCell(image: image)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 200)
    }
    
    func updateCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
