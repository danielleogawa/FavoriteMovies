//
//  CompletedMovie.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/05/07.
//

import UIKit

class CompletedMovie {
    public private(set) var simpleMovie: SimpleMovie
    public private(set) var posterImage: UIImage?
    public private(set) var movieDetail: MovieDetail?
    public private(set) var similarMovies: [Item]?
    public private(set) var cast: [Item]?
    public private(set) var providers: [MovieWatchProviders.WatchProvider]?

    init(simpleMovie: SimpleMovie) {
        self.simpleMovie = simpleMovie
    }
    
    @discardableResult
    func setMovieDetail(_ movieDetail: MovieDetail?) -> CompletedMovie {
        self.movieDetail = movieDetail
        return self
    }
    
    @discardableResult
    func setMoviePoster(_ posterImage: UIImage?) -> CompletedMovie {
        self.posterImage = posterImage
        return self
    }
    
    @discardableResult
    func setSimilarMovies(_ similarMovies: [Item]?) -> CompletedMovie {
        self.similarMovies = similarMovies
        return self
    }
    
    @discardableResult
    func setMovieCast(_ cast: [Item]?) -> CompletedMovie {
        self.cast = cast
        return self
    }
    
    @discardableResult
    func setMovieProviders(_ providers: [MovieWatchProviders.WatchProvider]?) -> CompletedMovie {
        self.providers = providers
        return self
    }
}
