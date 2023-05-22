//
//  MovieDetailViewModel.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/05/01.
//

import UIKit

protocol MovieDetailViewModelProtocol {
    func getPosterImage(completion: @escaping (UIImage) -> Void)
    func getMovieTitle() -> String?
    func getOverview() -> String?
    func getGenres() -> [String]?
    func setDelegate(delegate: MovieDetailScreenDelegate)
}

protocol MovieDetailScreenDelegate {
    func updateDetail()
    func updateSimilarMovies(movies: [Item])
    func updateCasts(with item: [Item])
}

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    
    var delegate: MovieDetailScreenDelegate?
    
    func setDelegate(delegate: MovieDetailScreenDelegate) {
        self.delegate = delegate
    }
    
    var movie: CompletedMovie

    var detail: MovieDetail? {
        didSet {
            delegate?.updateDetail()
        }
    }
    
    var similarMovies: [SimpleMovie]? {
        didSet {
            delegate?.updateSimilarMovies(movies: getSimilarMoviesItems())
        }
    }
    
    var cast: [Cast]? {
        didSet {
            delegate?.updateCasts(with: getCastsPersons())
        }
    }
    
    init(movie: CompletedMovie) {
        self.movie = movie
        self.requestMovieDetail()
        self.requestSimilarMovies()
        self.requestCastAndCrew()
    }
    
    
    func getCastsPersons() -> [Item] {
        guard let cast else { return [] }
        return cast.map { .init(imagePath: $0.profilePath, name: $0.name, caracter: $0.character)}
    }
    
    
    func getSimilarMoviesItems() -> [Item] {
        guard let similarMovies else { return [] }
        return similarMovies.map { .init(imagePath: $0.posterPath, name: $0.title, id: $0.id, popularity: $0.voteAverage)}
    }
    
    
    private func requestMovieDetail() {
        let url = Request.getUrl(with: .movie, movieID: movie.simpleMovie.id)
        Request.request(url: url, expecting: MovieDetail.self) { result in
            switch result {
            case .success(let movieDetail):
                self.detail = movieDetail
            case .failure(_):
                break
            }
        }
    }
    
    private func requestSimilarMovies() {
        let url = Request.getUrlForMovieDetails(with: movie.simpleMovie.id, moviePath: .similar)
        Request.request(url: url, expecting: List.self) { result in
            switch result {
            case .success(let data):
                self.similarMovies = data.results
            case .failure(_):
                break
            }
        }
    }
    
    private func requestCastAndCrew() {
        let url = Request.getUrlForMovieDetails(with: movie.simpleMovie.id, moviePath: .credits)
        
        Request.request(url: url, expecting: CreditList.self) { result in
            switch result {
            case .success(let data):
                self.cast = data.cast
            case .failure(_):
                break
            }
        }
    }

    func getMovieTitle() -> String? {
        return movie.simpleMovie.title
    }
    
    func getGenres() -> [String]? {
        guard let genres = detail?.genres else { return nil }
        var genresString = [String]()
        
        genres.forEach {
            if let name = $0.name {
                genresString.append(name)
            }
        }
        return genresString
    }
    
    func getPosterImage(completion: @escaping (UIImage) -> Void) {
        Request.getImage(movie: movie.simpleMovie) { image in
            completion(image)
        }
    }
    
    func getOverview() -> String? {
        return movie.simpleMovie.overview
    }
}
