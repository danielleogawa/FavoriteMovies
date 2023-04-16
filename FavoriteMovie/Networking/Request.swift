//
//  Request.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/04/16.
//

import Foundation

enum CustomError: Error {
    case invalidURL
    case invalidData
}

struct Request {
    
    static let apiKey = ""
    static let language = "&language=en-US"
    static let baseURL = "https://api.themoviedb.org/3/discover/movie?api_key="
    //https://api.themoviedb.org/3/discover/movie?api_key=a929d511c730708e667fd7fe46098969 &language=en-US &sort_by=popularity.desc
    
//https://api.themoviedb.org/3/discover/movie?a929d511c730708e667fd7fe46098969&language=en-US&sort_by=popularity.desc

    enum UrlPath: String {
        case mostPopularMovies = "&sort_by=popularity.desc"
        case onTheatres = "&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_date.gte=2023-01-01&primary_release_date.lte=2023-04-16&with_watch_monetization_types=flatrate"
        case highRatedMovies = "&certification_country=US&certification=R&sort_by=vote_average.desc"
        case mostPopularWithKids = "&certification_country=US&certification.lte=G&sort_by=popularity.desc"
    }
    
    static func getUrl(with path: UrlPath) -> URL? {
        let path = path.rawValue
        let urlString = baseURL + apiKey + language + path
        return URL(string: urlString)
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
                let result = try decoder.decode(expecting, from: data)
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
