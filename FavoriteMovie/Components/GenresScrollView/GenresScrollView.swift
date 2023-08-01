//
//  GenresScrollView.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/05/27.
//

import UIKit

class GenresScrollView: UIView {
    
    lazy var scrollContentView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var scrollView: UIScrollView = {
        let element = UIScrollView()
        element.alwaysBounceHorizontal = true
        element.showsHorizontalScrollIndicator = true
        element.isScrollEnabled = true
        element.isPagingEnabled = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var stackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .horizontal
        element.distribution = .fill
        element.spacing = 8
        return element
    }()
    
    init() {
        super.init(frame: .zero)
        setScrollView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setScrollView() {
        addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
//            scrollView.centerYAnchor.constraint(equalTo: centerYAnchor),
            scrollView.widthAnchor.constraint(equalTo: widthAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            scrollContentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContentView.widthAnchor.constraint(equalTo: stackView.widthAnchor)
//            scrollContentView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    private func setGenresStack(genres: [String]) {
        DispatchQueue.main.async { [self] in
            genres.forEach { stackView.addArrangedSubview(setGenre(text: $0))}
            self.scrollContentView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
            scrollView.contentSize.width = scrollContentView.frame.width
        }
    }
    
    private func setGenre(text: String) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.darkMagenta
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: label.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            view.heightAnchor.constraint(equalToConstant: 30),
            view.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: -8),
            view.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8)
        ])
        return view
    }
    
    func updateList(_ list: [String]) {
        setGenresStack(genres: list)
    }
    
}
