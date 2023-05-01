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
    
    lazy var highLightedSectionLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font.withSize(16)
        element.textColor = .white
        return element
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.viewModel = HightLightMoviesViewModel(delegate: self)
        self.backgroundColor = .clear
        setCollectionViewDelegate()
        setSectionLabel()
        setCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCollectionViewDelegate() {
        collectionView.register(HightLightMovieCollectionViewCell.self, forCellWithReuseIdentifier: HightLightMovieCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setSectionLabel() {
        contentView.addSubview(highLightedSectionLabel)
        NSLayoutConstraint.activate([
            highLightedSectionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            highLightedSectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            highLightedSectionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            highLightedSectionLabel.heightAnchor.constraint(equalToConstant: 24)
            
        ])
    }
    
    private func setCollectionView() {
        contentView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: highLightedSectionLabel.bottomAnchor, constant: 8),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    

    
    func setCellForRow(_ row: Int){
        viewModel?.setCategoryOfRow(row)
        self.highLightedSectionLabel.text = viewModel?.getSectionTitle(row: row)
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
        return CGSize(width: 170, height: 270)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel?.getMovie(row: indexPath.row)
    }
    
    func updateCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
