//
//  HomeScreen.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/04/16.
//

import UIKit

final class HomeScreen: UIView {
    
    typealias Delegate = UITableViewDelegate & UITableViewDataSource
    
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
    
    lazy var homeTableView: UITableView = {
        let element = UITableView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .clear
        element.allowsSelection = false
        element.separatorStyle = .none
        element.register(OnTheatresTableViewCell.self, forCellReuseIdentifier: OnTheatresTableViewCell.identifier)
//        element.isScrollEnabled = true
        return element
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTableView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBackground( ){
        self.gradientBackground.frame = bounds
        layer.insertSublayer(gradientBackground, at: 0)
    }
    
    func setDelegate(delegate: Delegate) {
        self.homeTableView.delegate = delegate
        self.homeTableView.dataSource = delegate
    }
    
    func setTableView() {
        addSubview(homeTableView)
        NSLayoutConstraint.activate([
            homeTableView.topAnchor.constraint(equalTo: topAnchor),
            homeTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            homeTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            homeTableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
