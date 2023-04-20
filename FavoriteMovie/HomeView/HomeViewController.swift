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
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.mainMovies.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMovieCollectionViewCell.identifier, for: indexPath) as? HomeMovieCollectionViewCell {
            
            //TODO: refatorar
            
            let movie = viewModel?.mainMovies[indexPath.row]
            viewModel?.getImage(movie: movie, completion: { downloadedImage in
                cell.setCell(with: downloadedImage, movie: movie)
            })
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 600)
    }

}

extension HomeViewController: HomeViewViewModelDelegate {
    func updateCollectionView() {
        DispatchQueue.main.async {
            self.screen?.mainCollectionView.reloadData()
        }
    }
}
