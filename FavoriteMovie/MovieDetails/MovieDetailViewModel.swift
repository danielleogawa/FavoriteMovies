//
//  MovieDetailViewModel.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/07/30.
//

import UIKit
protocol MovieDetailViewModelProtocol {
    var movie: CompletedMovie { get set }
    func getPosterImage() -> UIImage?
    func getMovieTitle() -> String?
    func getOverview() -> String?
    func getGenres() -> [String]?
    func getCast() -> [Item]?
    func getSimilarMovies() -> [Item]?
}

class MovieDetailViewModel: MovieDetailViewModelProtocol {
    var movie: CompletedMovie
    
    init(movie: CompletedMovie) {
        self.movie = movie
    }

    func getMovieTitle() -> String? {
        return movie.simpleMovie.title
    }

    func getGenres() -> [String]? {
        guard let genres = movie.movieDetail?.genres else { return nil }
        var genresString = [String]()
        genres.forEach {
            if let name = $0.name {
                genresString.append(name)
            }
        }
        return genresString
    }
    
    func getPosterImage() -> UIImage? {
        return movie.posterImage
    }
    
    func getOverview() -> String? {
        return movie.simpleMovie.overview
    }
    
    func getCast() -> [Item]? {
        movie.cast
    }
    
    func getSimilarMovies() -> [Item]? {
        movie.similarMovies
    }
}
