//
//  Request.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/04/16.
//

import UIKit

enum CustomError: Error {
    case invalidURL
    case invalidData
}

struct Request {
    //TODO: get the user device laguage
    //TODO: get the current date
    
    static let apiKey = ""
    static let language = "&language=en-US"
    static let baseURL = "https://api.themoviedb.org/3"
    
    enum Path: String {
        case discover = "/discover/movie"
        case genre = "/genre/movie/list"
        case popularMovies = "/movie/popular"
        case upComingMovies = "/movie/upcoming"
        case lastedMovies = "/movie/latest"
        case nowPlayingMovies = "/movie/now_playing"
    }
    
    enum UrlPath: String {
        case mostPopularMovies = "&sort_by=popularity.desc"
        case onTheatres = "&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_date.gte=2023-01-01&primary_release_date.lte=2023-04-16&with_watch_monetization_types=flatrate"
        case highRatedMovies = "&certification_country=US&certification=R&sort_by=vote_average.desc"
        case mostPopularWithKids = "&certification_country=US&certification.lte=G&sort_by=popularity.desc"
    }
    
    static func getUrl(with path: Path, urlPath: UrlPath? = nil) -> URL? {
        let midlePath = path.rawValue
        var urlString = baseURL + midlePath + apiKey + language
        if let path = urlPath?.rawValue {
            urlString = urlString + path
        }
        return URL(string: urlString)
    }
    
    static func getImageURL(posterPath: String) -> URL? {
        let imageURLBase = "https://image.tmdb.org/t/p/w500"
        let urlString = imageURLBase + posterPath
        return URL(string: urlString)
    }
    
    static func downloadImage(from url: URL, completion: @escaping (UIImage?, Error?) -> Void) {

        let requestURL = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, _, _ in
            DispatchQueue.main.async {
                guard let data else {
                    completion(nil, CustomError.invalidData)
                    return
                }
                completion(UIImage(data: data), nil)
            }
        }
        task.resume()
       
    }
    
    static func request<T: Codable>(url: URL?,
                                    expecting: T.Type,
                                    completion: @escaping (Result<T, Error>) -> Void) {
        guard let url else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        let requestURL = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            guard let data else {
                if let error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    static func getImage(movie: Movie?, completion: @escaping (UIImage) -> Void) {
        guard let posterPath = movie?.posterPath,
              let url = Request.getImageURL(posterPath: posterPath) else {
            return
        }
        Request.downloadImage(from: url) { result, _  in
            if let result {
                completion(result)
            }
        }
    }
    
}
