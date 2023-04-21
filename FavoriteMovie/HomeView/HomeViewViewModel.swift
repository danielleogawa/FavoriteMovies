//
//  HomeViewViewModel.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/04/17.
//

import UIKit

protocol HomeViewViewModelDelegate {
    func updateCollectionView()
}

final class HomeViewViewModel {
    
    var delegate: HomeViewViewModelDelegate?
    
    private(set) var mainMovies = [Movie]() {
        didSet { delegate?.updateCollectionView() }
    }
    
    init(delegate: HomeViewViewModelDelegate) {
        self.delegate = delegate
        getMovies()
    }
    
    private func getMovies() {
        let url = Request.getUrl(with: .onTheatres)
        
        Request.request(url: url, expecting: List.self) { result in
            switch result {
            case .success(let list):
                if let movies = list.results {
                    self.mainMovies = movies
                }
            case .failure(_):
                self.mainMovies = []
            }
        }
    }
    
    func getImage(movie: Movie?, completion: @escaping (UIImage) -> Void) {
        guard let posterPath = movie?.posterPath,
              let url = Request.getImageURL(posterPath: posterPath) else {
            return
        }
        Request.downloadImage(from: url) { result, _  in
            if let result {
                completion(result)
            }
        }
    }
    
    
    
}
