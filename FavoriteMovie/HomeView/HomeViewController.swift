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
        return viewModel?.mainMovies.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMovieCollectionViewCell.identifier, for: indexPath) as? HomeMovieCollectionViewCell {
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


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: OnTheatresTableViewCell.identifier, for: indexPath) as? OnTheatresTableViewCell {
                cell.setDelegate(delegate: self)
//                viewModel?.delegate?.updateCollectionView(cell: cell.collectionView)
              return cell
            }
        }
        return UITableViewCell()
    }
    
    
}

extension HomeViewController: HomeViewViewModelDelegate {
    func updateCollectionView(cell: UICollectionView?) {
        DispatchQueue.main.async {
            cell?.reloadData()
        }
    }
}
