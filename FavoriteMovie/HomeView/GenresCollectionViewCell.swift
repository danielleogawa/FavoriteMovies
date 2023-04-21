//
//  GenresCollectionViewCell.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/04/21.
//

import UIKit

class GenresCollectionViewCell: UICollectionViewCell {
    static let identifier = "GenresCollectionViewCell"
    
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
    
    lazy var circleView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.clipsToBounds = true
        element.layer.cornerRadius = 50
        element.layer.borderWidth = 2
        element.layer.borderColor = Colors.darkMagenta.cgColor
        return element
    }()
    
    lazy var title: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.textColor = .white
        element.font = .systemFont(ofSize: 12, weight: .medium)
        element.lineBreakStrategy = .standard
        element.text = "teste"
        return element
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCircleView()
        setTitle()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientBackground.frame = circleView.frame
        circleView.layer.insertSublayer(gradientBackground, at: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCircleView() {
        addSubview(circleView)
        NSLayoutConstraint.activate([
            circleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            circleView.trailingAnchor.constraint(equalTo: trailingAnchor),
            circleView.topAnchor.constraint(equalTo: topAnchor),
            circleView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setTitle() {
        circleView.addSubview(title)
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: circleView.centerYAnchor)
        ])
    }
    
    func setCell(genreTitle: String?) {
        self.title.text = genreTitle
    }
}
