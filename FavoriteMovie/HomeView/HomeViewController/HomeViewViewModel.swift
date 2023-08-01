//
//  HomeViewViewModel.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/04/17.
//

import UIKit

protocol HomeViewViewModelDelegate {
    func updateCollectionView()
    func updateGenreCollectionView()
}

final class HomeViewViewModel {
    
    var delegate: HomeViewViewModelDelegate?
    
    private(set) var mainMovies = [SimpleMovie]() {
        didSet {
            delegate?.updateCollectionView()
        }
    }
    
    private(set) var genres = [Genre]() {
        didSet {
            delegate?.updateGenreCollectionView()
        }
    }
    
    init(delegate: HomeViewViewModelDelegate?) {
        self.delegate = delegate
        getMovies()
        getGenres()
    }
    
    private func getMovies() {
        let url = Request.getUrl(with: .discover, urlPath: .onTheatres)
        
        Request().request(url: url, expecting: List.self) { result in
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
    
    private func getGenres() {
        let url = Request.getUrl(with: .genre)
        
        Request().request(url: url, expecting: GenreList.self) { result in
            switch result {
            case .success(let genreList):
                self.genres = genreList.genres ?? []
            case .failure(_):
                self.genres = []
            }
        }
    }
    
    func getGenre(of row: Int) -> Genre {
        return genres[row]
    }
    
    func getMovieDetailViewModel(row: Int) -> MovieDetailLoadingViewModel {
        let movie = mainMovies[row]
        return MovieDetailLoadingViewModel(movie: .init(simpleMovie: movie))
    }
    
}
