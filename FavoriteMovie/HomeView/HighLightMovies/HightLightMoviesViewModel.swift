//
//  HightLightMoviesViewModel.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/05/01.
//

import Foundation

protocol HightLightMoviesDelegate {
    func updateCollectionView()
}

final class HightLightMoviesViewModel {
    var delegate: HightLightMoviesDelegate?
    
    private(set) var popularMovies = [Movie]() {
        didSet {
            delegate?.updateCollectionView()
        }
    }
    
    private(set) var upComingMovies = [Movie]() {
        didSet {
            delegate?.updateCollectionView()
        }
    }
    
    private(set) var nowPlayingMovies = [Movie]() {
        didSet {
            delegate?.updateCollectionView()
        }
    }
    
    enum CollectionViewCategories: CaseIterable {
        case popularMovies
        case upComing
        case nowPlaying
        
        var url: URL? {
            switch self {
            case .popularMovies:
               return Request.getUrl(with: .popularMovies)
            case .upComing:
                return Request.getUrl(with: .upComingMovies)
            case .nowPlaying:
                return Request.getUrl(with: .nowPlayingMovies)
            }
        }
        
        func getCategories(completion: @escaping ([Movie]) -> Void){
            Request.request(url: self.url, expecting: List.self) { result in
                switch result {
                case .success(let list):
                    if let listMovies = list.results {
                        completion(listMovies)
                    }
                case .failure(_):
                     break
                }
            }
        }
    }
    
    private var categoryRow: Int?

    init(delegate: HightLightMoviesDelegate? = nil) {
        self.delegate = delegate
        loadMovies()
    }
    
    func setCategoryOfRow(_ row: Int) {
        self.categoryRow = row
    }
    
    func getCurrentlyCategory() -> [Movie] {
        let categories = [popularMovies, upComingMovies, nowPlayingMovies]
        return categories[categoryRow ?? 0]
    }
    
    func getNumberOfCollectionViewCell() -> Int {
        getCurrentlyCategory().count
    }
    
    private func loadMovies() {
        CollectionViewCategories.popularMovies.getCategories { movies in
            self.popularMovies = movies
        }
        CollectionViewCategories.nowPlaying.getCategories { movies in
            self.nowPlayingMovies = movies
        }
        CollectionViewCategories.upComing.getCategories { movies in
            self.upComingMovies = movies
        }
    }
    
    func getMovie(row: Int) -> Movie? {
        return getCurrentlyCategory()[row]
    }
}

