//
//  MovieDetailViewModel.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/05/01.
//

import UIKit

enum LoadingState {
    case idle
    case loading
    case loaded
}

protocol LoadProtocol {
    func loadedView(_ movie: CompletedMovie)
}

final class MovieDetailLoadingViewModel {
    private var movie: CompletedMovie
    private var loadDelegate: LoadProtocol?
    private let requestGroup = DispatchGroup()

    func setLoadDelegate(delegate: LoadProtocol) {
        self.loadDelegate = delegate
    }
    
    var loadingState: LoadingState = .idle {
        didSet {
            updateMovieDetail()
            loadDelegate?.loadedView(movie)
        }
    }
    
    var detail: MovieDetail?
    
    var posterImage: UIImage?
    
    var similarMovies: [SimpleMovie]?
    
    var cast: [Cast]?
    
    var providers: [MovieWatchProviders.WatchProvider]?
    
    init(movie: CompletedMovie) {
        self.movie = movie
        self.requestMovieDetail()
        self.requestSimilarMovies()
        self.requestCastAndCrew()
        self.requestWatchProviders()
        self.getPosterImage()
        self.updateState()
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
        requestGroup.enter()
        Request().request(url: url, expecting: MovieDetail.self) { result in
            switch result {
            case .success(let movieDetail):
                self.detail = movieDetail
                self.requestGroup.leave()
            case .failure(_):
                break
            }
        }
    }
    
    private func requestSimilarMovies() {
        let url = Request.getUrlForMovieDetails(with: movie.simpleMovie.id, moviePath: .similar)
        requestGroup.enter()
        Request().request(url: url, expecting: List.self) { result in
            switch result {
            case .success(let data):
                self.similarMovies = data.results
                self.requestGroup.leave()
            case .failure(_):
                break
            }
        }
    }
    
    private func requestCastAndCrew() {
        let url = Request.getUrlForMovieDetails(with: movie.simpleMovie.id, moviePath: .credits)
        requestGroup.enter()
        Request().request(url: url, expecting: CreditList.self) { result in
            switch result {
            case .success(let data):
                self.cast = data.cast
                self.requestGroup.leave()
            case .failure(_):
                break
            }
        }
    }
    
    private func requestWatchProviders() {
        let url = Request.getUrlForMovieDetails(with: movie.simpleMovie.id, moviePath: .providers)
        requestGroup.enter()
        Request().request(url: url, expecting: MovieWatchProviders.self) { result in
            switch result {
            case .success(let data):
                self.providers = self.filterWatchProviders(data.results?.US?.rent)
                self.requestGroup.leave()
            case .failure(_):
                break
            }
        }
    }
    
    private func filterWatchProviders(_ providers: [MovieWatchProviders.WatchProvider]?) -> [MovieWatchProviders.WatchProvider] {
        guard let providers else { return [] }
        let providersID: [Double] = [2, 3, 10, 192]
        return providers.filter { providersID.contains($0.providerId)}
    }
    
    private func updateState() {
        requestGroup.notify(queue: .main) {
            self.loadingState = .loaded
        }
    }
    
    private func getPosterImage() {
        requestGroup.enter()
            Request().getImage(movie: self.movie.simpleMovie) { image in
                self.posterImage = image
                self.requestGroup.leave()
            }
    }
    
    private func updateMovieDetail() {
        self.movie
            .setMovieDetail(detail)
            .setMoviePoster(posterImage)
            .setSimilarMovies(getSimilarMoviesItems())
            .setMovieCast(getCastsPersons())
            .setMovieProviders(providers)
    }
    
}
