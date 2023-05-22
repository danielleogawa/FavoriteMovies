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
    private var hasBottomInfo: Bool = false
    
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
    
    lazy var starImage: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(systemName: "star.fill")
        element.tintColor = .white
        return element
    }()
    
    lazy var contentViewImage: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.clipsToBounds = true
        element.layer.cornerRadius = 5
        return element
    }()
    
    lazy var contentViewGradientBackground: CAGradientLayer = {
        let element = CAGradientLayer()
        element.type = .axial
        element.colors = [
            UIColor.clear.cgColor,
            Colors.darkMagenta.cgColor.copy(alpha: 0.7)
        ]
        element.locations = [0, 0.9]
        return element
    }()
    
    lazy var contentViewInformation: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .clear
        return element
    }()
    
    lazy var voteAverageLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = viewModel?.getAverage()
        element.textColor = .white.withAlphaComponent(0.8)
        element.font = .boldSystemFont(ofSize: 10)
        element.numberOfLines = 0
        return element
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func updateViewModel(_ viewModel: GenericCollectionViewCellViewModel, imageHeight: Int, hasBottomInfo: Bool) {
        self.viewModel = viewModel
        self.hasBottomInfo = hasBottomInfo 
        setContentViewCell(height: imageHeight + 40)
        setImage(imageHeight: imageHeight)
        setNameLabel()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        setBackground()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBackground(){
        guard hasBottomInfo else { return }
        contentViewCell.addSubview(contentViewImage)
        contentViewImage.frame = iconImage.bounds
        contentViewImage.layer.addSublayer(contentViewGradientBackground)
        contentViewGradientBackground.frame = contentViewImage.bounds
        setInformationView()
    }
    
    private func setInformationView() {
        addSubview(contentViewInformation)
        contentViewInformation.addSubview(starImage)
        contentViewInformation.addSubview(voteAverageLabel)
        NSLayoutConstraint.activate([
            contentViewInformation.leadingAnchor.constraint(equalTo: iconImage.leadingAnchor),
            contentViewInformation.trailingAnchor.constraint(equalTo: iconImage.trailingAnchor),
            contentViewInformation.bottomAnchor.constraint(equalTo: iconImage.bottomAnchor),
            contentViewInformation.trailingAnchor.constraint(equalTo: iconImage.trailingAnchor),
            starImage.leadingAnchor.constraint(equalTo: contentViewInformation.leadingAnchor, constant: 8),
            starImage.bottomAnchor.constraint(equalTo: contentViewInformation.bottomAnchor, constant: -8),
            starImage.heightAnchor.constraint(equalToConstant: 15),
            starImage.widthAnchor.constraint(equalToConstant: 15),
            voteAverageLabel.leadingAnchor.constraint(equalTo: starImage.trailingAnchor, constant: 8),
            voteAverageLabel.trailingAnchor.constraint(equalTo: contentViewInformation.trailingAnchor, constant: -8),
            voteAverageLabel.centerYAnchor.constraint(equalTo: starImage.centerYAnchor)
        ])
    }
    
    func setContentViewCell(height: Int) {
        addSubview(contentViewCell)
        NSLayoutConstraint.activate([
            contentViewCell.topAnchor.constraint(equalTo: topAnchor),
            contentViewCell.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentViewCell.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentViewCell.heightAnchor.constraint(equalToConstant: CGFloat(integerLiteral: height))
        ])
    }

    func setImage(imageHeight: Int) {
        contentViewCell.addSubview(iconImage)
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: topAnchor),
            iconImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImage.trailingAnchor.constraint(equalTo: trailingAnchor),
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
