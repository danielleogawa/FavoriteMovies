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
}

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    func setDelegate(delegate: MovieDetailScreenDelegate) {
        self.delegate = delegate
    }
    
    var movie: CompletedMovie
    var delegate: MovieDetailScreenDelegate?
    var detail: MovieDetail? {
        didSet {
            delegate?.updateDetail()
        }
    }
    
    init(movie: CompletedMovie) {
        self.movie = movie
        self.requestMovieDetail()
    }
    
    func requestMovieDetail() {
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
