//
//  CastView.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/05/18.
//

import UIKit

class GenericCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "GenericCollectionViewCellIdentifier"
    
    var viewModel: GenericCollectionViewCellViewModel?

    lazy var contentViewCell: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var iconImage: UIImageView = {
        let element = UIImageView()
        element.image = viewModel?.image
        element.translatesAutoresizingMaskIntoConstraints = false
        element.clipsToBounds = true
        element.layer.cornerRadius = 5
        element.contentMode = .scaleAspectFill
        return element
    }()
    
    lazy var nameLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = viewModel?.getName()
        element.textColor = .white.withAlphaComponent(0.8)
        element.font = .boldSystemFont(ofSize: 10)
        element.numberOfLines = 0 
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func updateViewModel(_ viewModel: GenericCollectionViewCellViewModel, imageHeight: Int) {
        self.viewModel = viewModel
        setContentViewCell(height: imageHeight + 40)
        setImage(imageHeight: imageHeight)
        setNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContentViewCell(height: Int) {
        addSubview(contentViewCell)
        NSLayoutConstraint.activate([
            contentViewCell.topAnchor.constraint(equalTo: topAnchor),
            contentViewCell.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentViewCell.leadingAnchor.constraint(equalTo: leadingAnchor),
//            contentViewCell.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentViewCell.heightAnchor.constraint(equalToConstant: CGFloat(integerLiteral: height))
        ])
    }

    func setImage(imageHeight: Int) {
        contentViewCell.addSubview(iconImage)
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: topAnchor),
            iconImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImage.trailingAnchor.constraint(equalTo: trailingAnchor),
//            iconImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImage.heightAnchor.constraint(equalToConstant: CGFloat(integerLiteral: imageHeight))
        ])
    }
    
    func setNameLabel() {
        contentViewCell.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
