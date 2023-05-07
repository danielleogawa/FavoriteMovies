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
}

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    
    var movie: CompletedMovie
    
    init(movie: CompletedMovie) {
        self.movie = movie
    }
    
    func getMovieTitle() -> String? {
        return movie.simpleMovie.title
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
