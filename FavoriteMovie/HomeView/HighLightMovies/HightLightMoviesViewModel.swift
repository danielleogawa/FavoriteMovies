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

enum CollectionViewCategories: String, CaseIterable {
    case popularMovies = "popularMovies"
    case upComingMovies = "upComingMovies"
    case nowPlayingMovies = "nowPlayingMovies"
    
    var url: URL? {
        switch self {
        case .popularMovies:
           return Request.getUrl(with: .popularMovies)
        case .upComingMovies:
            return Request.getUrl(with: .upComingMovies)
        case .nowPlayingMovies:
            return Request.getUrl(with: .nowPlayingMovies)
        }
    }
    
    var title: String {
        switch self {
        case .popularMovies:
            return "Popular Movies"
        case .upComingMovies:
            return "Up Coming Movies"
        case .nowPlayingMovies:
            return "Now Playing"
        }
    }
    
    func getCategories(completion: @escaping ([SimpleMovie]) -> Void){
        Request().request(url: self.url, expecting: List.self) { result in
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


final class HightLightMoviesViewModel {
    var delegate: HightLightMoviesDelegate?
    
    private(set) var popularMovies = [SimpleMovie]() {
        didSet {
            delegate?.updateCollectionView()
        }
    }
    
    private(set) var upComingMovies = [SimpleMovie]() {
        didSet {
            delegate?.updateCollectionView()
        }
    }
    
    private(set) var nowPlayingMovies = [SimpleMovie]() {
        didSet {
            delegate?.updateCollectionView()
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
    
    func getCurrentlyCategory() -> [SimpleMovie] {
        let categoriesEnum = CollectionViewCategories.allCases
        var categories: [[SimpleMovie]] = []

        categoriesEnum.forEach { category in
            if category.rawValue == CollectionViewCategories.popularMovies.rawValue {
                categories.append(popularMovies)
            } else if category.rawValue == CollectionViewCategories.nowPlayingMovies.rawValue {
                categories.append(nowPlayingMovies)
            } else if category.rawValue == CollectionViewCategories.upComingMovies.rawValue {
                categories.append(upComingMovies)
            }
        }
        return categories[categoryRow ?? 0]
    }
    
    func getNumberOfCollectionViewCell() -> Int {
        getCurrentlyCategory().count
    }
    
    private func loadMovies() {
        CollectionViewCategories.popularMovies.getCategories { movies in
            self.popularMovies = movies
        }
        CollectionViewCategories.nowPlayingMovies.getCategories { movies in
            self.nowPlayingMovies = movies
        }
        CollectionViewCategories.upComingMovies.getCategories { movies in
            self.upComingMovies = movies
        }
    }
    
    func getMovie(row: Int) -> SimpleMovie? {
        return getCurrentlyCategory()[row]
    }
    
    func getSectionTitle(row: Int) -> String {
        return CollectionViewCategories.allCases[row].title
    }
}

