//
//  MovieDetailScreen.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/05/01.
//

import UIKit

final class MovieDetailScreen: UIView {
    
    private var screenDelegate: MovieDetailViewModelProtocol?

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
    
    lazy var scrollContentView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var scrollView: UIScrollView = {
        let element = UIScrollView()
        element.contentInsetAdjustmentBehavior = .always
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    lazy var posterImage: UIImageView = {
        var element = UIImageView()
        element.image = screenDelegate?.getPosterImage()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFill
        element.backgroundColor = .gray
        return element
    }()
    
    lazy var favoriteButton: UIButton = {
        let element = UIButton()
        element.setImage(UIImage(systemName: "heart"), for: .normal)
        element.addTarget(self, action: #selector(self.favoriteButtonTapped), for: .touchUpInside)
        return element
    }()
    
    lazy var contentViewBackground: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var contentViewGradientBackground: CAGradientLayer = {
        let element = CAGradientLayer()
        element.type = .axial
        element.colors = [
            UIColor.clear.cgColor,
            Colors.darkGray.cgColor
        ]
        element.locations = [0, 0.07]
        return element
    }()
    
    lazy var contentView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var contentViewStack: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.spacing = 16
        element.alignment = .leading
        element.axis = .vertical
        return element
    }()
    
    lazy var overviewLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .systemFont(ofSize: 14)
        element.numberOfLines = 0 
        element.text = screenDelegate?.getOverview()
        element.textColor = .white.withAlphaComponent(0.8)
        return element
    }()
    
    let castCollectionView = GenericCollectionView(viewModel: .init(
        collectionViewTitle: "Meet the cast",
        items: []),collectionViewHeight: 100, hasBottomInfo: false
    )
    
    let similarMoviesCollectionView = GenericCollectionView(viewModel: .init(
        collectionViewTitle: "Watch similar movies",
        items: []), collectionViewHeight: 170, width: 120, hasBottomInfo: true
    )
    
    let genresView = GenresScrollView()
    
    init(delegate: MovieDetailViewModelProtocol?) {
        super.init(frame: .zero)
        self.screenDelegate = delegate
        setScrollView()
        setPosterImage()
        setContentView()
        setScrollContentView()
        setContentViewStack()
        setGenresStack()
        contentViewStack.addArrangedSubview(self.overviewLabel)
        setCastCollectionView()
        setSimilarMoviesCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBackground(){
        self.gradientBackground.frame = bounds
        layer.insertSublayer(gradientBackground, at: 0)
        self.contentViewGradientBackground.frame = contentViewBackground.bounds
        contentViewBackground.layer.addSublayer(contentViewGradientBackground)
    }
    

    private func setScrollView() {
        addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: widthAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollContentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            scrollContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func setPosterImage(){
        scrollContentView.addSubview(posterImage)
        
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: scrollContentView.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
            posterImage.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    private func setContentView() {
        scrollContentView.addSubview(contentViewBackground)
        NSLayoutConstraint.activate([
            contentViewBackground.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: -100),
            contentViewBackground.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor),
            contentViewBackground.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
            contentViewBackground.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor)
        ])
    }
    
    private func setScrollContentView() {
        scrollContentView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: -100),
            contentView.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor)
        ])
    }
    
    private func setContentViewStack() {
        contentView.addSubview(contentViewStack)
        NSLayoutConstraint.activate([
            contentViewStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            contentViewStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            contentViewStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            scrollContentView.bottomAnchor.constraint(equalTo: contentViewStack.bottomAnchor, constant: 24)
        ])
    }
    
    private func setCastCollectionView() {
        castCollectionView.updateViewModel(with: screenDelegate?.getCast() ?? [])
        contentViewStack.addArrangedSubview(castCollectionView)
        castCollectionView.layoutSubviews()
        NSLayoutConstraint.activate([
            castCollectionView.heightAnchor.constraint(equalToConstant: 180),
            castCollectionView.leadingAnchor.constraint(equalTo: contentViewStack.leadingAnchor),
            castCollectionView.trailingAnchor.constraint(equalTo: contentViewStack.trailingAnchor)
        ])
    }
    
    private func setSimilarMoviesCollectionView() {
        similarMoviesCollectionView.updateViewModel(with: screenDelegate?.getSimilarMovies() ?? [])
        contentViewStack.addArrangedSubview(similarMoviesCollectionView)
        similarMoviesCollectionView.layoutSubviews()
        NSLayoutConstraint.activate([
            similarMoviesCollectionView.heightAnchor.constraint(equalToConstant: 250),
            similarMoviesCollectionView.leadingAnchor.constraint(equalTo: contentViewStack.leadingAnchor),
            similarMoviesCollectionView.trailingAnchor.constraint(equalTo: contentViewStack.trailingAnchor)
        ])
    }
    
    private func setGenresStack() {
        genresView.updateList(screenDelegate?.getGenres() ?? [])
        contentViewStack.addArrangedSubview(genresView)
        genresView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genresView.heightAnchor.constraint(equalToConstant: 30),
            genresView.leadingAnchor.constraint(equalTo: contentViewStack.leadingAnchor),
            genresView.trailingAnchor.constraint(equalTo: contentViewStack.trailingAnchor),
        ])
    }
    
    func setNavigationController(viewController: UIViewController) {
        viewController.navigationItem.title = screenDelegate?.getMovieTitle()
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteButton)
    }
}

//MARK: - Button functions
extension MovieDetailScreen {
    @objc func favoriteButtonTapped() {
        print("favoritou")
    }
    
}
