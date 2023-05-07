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
}

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func getMovieTitle() -> String? {
        return movie.title
    }
    
    func getPosterImage(completion: @escaping (UIImage) -> Void) {
        Request.getImage(movie: movie) { image in
            completion(image)
        }
    }
    
}
