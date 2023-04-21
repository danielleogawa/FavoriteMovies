//
//  ViewController.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/04/15.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewViewModel?
    var screen: HomeScreen?
    
    override func loadView() {
        super.loadView()
        self.view = screen
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.screen = HomeScreen()
        self.screen?.setDelegate(delegate: self)
        self.screen?.setDelegateGener(delegate: self)
        self.viewModel = HomeViewViewModel(delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        screen?.setBackground()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    func setNavigationBar() {
        let apparence = UINavigationBarAppearance()
        apparence.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        apparence.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        apparence.backgroundColor = Colors.darkMagenta.withAlphaComponent(0.2)
        navigationController?.navigationBar.standardAppearance = apparence
        navigationController?.navigationBar.isTranslucent = true
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == screen?.onTheatresCollectionView {
            return viewModel?.mainMovies.count ?? 0
        }
        if collectionView == screen?.genresCollectionView {
            return viewModel?.genres.count ?? 0 
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == screen?.onTheatresCollectionView,
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMovieCollectionViewCell.identifier,
                                                         for: indexPath) as? HomeMovieCollectionViewCell {
            let movie = viewModel?.mainMovies[indexPath.row]
            viewModel?.getImage(movie: movie, completion: { downloadedImage in
                cell.setCell(with: downloadedImage, movie: movie)
            })
            return cell
        }
        if collectionView == screen?.genresCollectionView,
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenresCollectionViewCell.identifier,
                                                         for: indexPath) as? GenresCollectionViewCell {
            let genre = viewModel?.getGenre(of: indexPath.row)
            cell.setCell(genreTitle: genre?.name)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == screen?.onTheatresCollectionView {
            return CGSize(width: self.view.bounds.width, height: 600)
        } else if collectionView == screen?.genresCollectionView {
            return CGSize(width: 100, height: 100)
        }
        return CGSize(width: 0, height: 0)
    }
    
}

extension HomeViewController: HomeViewViewModelDelegate {
    func updateGenreCollectionView() {
        DispatchQueue.main.async {
            self.screen?.genresCollectionView.reloadData()
        }
    }
    
    func updateCollectionView() {
        DispatchQueue.main.async {
            self.screen?.onTheatresCollectionView.reloadData()
        }
    }
}
