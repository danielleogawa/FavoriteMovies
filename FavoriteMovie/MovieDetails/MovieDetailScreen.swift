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
    
    init(delegate: MovieDetailViewModelProtocol?) {
        super.init(frame: .zero)
        self.screenDelegate = delegate
        self.screenDelegate?.setDelegate(delegate: self)
        setScrollView()
        setPosterImage()
        setImages()
        setContentView()
        setScrollContentView()
        setContentViewStack()
        setCastCollectionView()
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
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContentView.heightAnchor.constraint(equalToConstant: 1700)
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
            contentViewStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
    }
    
    //MARK: - function that organize main stack view
    private func setStackContents() {
        DispatchQueue.main.async {
            self.contentViewStack.addArrangedSubview(self.overviewLabel)
            self.setCastCollectionView()
            self.setSimilarMoviesCollectionView()
        }
    }
    
    private func setCastCollectionView() {
        contentViewStack.addArrangedSubview(castCollectionView)
        castCollectionView.layoutSubviews()
        NSLayoutConstraint.activate([
            castCollectionView.heightAnchor.constraint(equalToConstant: 180),
            castCollectionView.leadingAnchor.constraint(equalTo: contentViewStack.leadingAnchor),
            castCollectionView.trailingAnchor.constraint(equalTo: contentViewStack.trailingAnchor)
        ])
    }
    
    private func setSimilarMoviesCollectionView() {
        contentViewStack.addArrangedSubview(similarMoviesCollectionView)
        similarMoviesCollectionView.layoutSubviews()
        NSLayoutConstraint.activate([
            similarMoviesCollectionView.heightAnchor.constraint(equalToConstant: 250),
            similarMoviesCollectionView.leadingAnchor.constraint(equalTo: contentViewStack.leadingAnchor),
            similarMoviesCollectionView.trailingAnchor.constraint(equalTo: contentViewStack.trailingAnchor)
        ])
    }
    
    private func setGenresStack(genres: [String]) {
        DispatchQueue.main.async { [self] in
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.spacing = 8
            genres.forEach { stack.addArrangedSubview(setGenre(text: $0))}
            contentViewStack.addArrangedSubview(stack)
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
    
    func setNavigationController(viewController: UIViewController) {
        viewController.navigationItem.title = screenDelegate?.getMovieTitle()
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteButton)
    }
}

extension MovieDetailScreen: MovieDetailScreenDelegate {
    func updateCasts(with persons: [Item]) {
        castCollectionView.updateViewModel(with: persons)
    }
    
    func updateDetail() {
        if let genres = screenDelegate?.getGenres() {
          setGenresStack(genres: genres)
        }
        setStackContents()
    }
    
    func updateSimilarMovies(movies: [Item]) {
        similarMoviesCollectionView.updateViewModel(with: movies)
    }
}

//MARK: - Updates elements in the screen
extension MovieDetailScreen {
    func setImages() {
        screenDelegate?.getPosterImage(completion: { image in
            self.posterImage.image = image
        })
    }
}

//MARK: - Button functions
extension MovieDetailScreen {
    @objc func favoriteButtonTapped() {
        print("favoritou")
    }
    
}
