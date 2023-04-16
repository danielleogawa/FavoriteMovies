//
//  Auth.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/04/16.
//

import Foundation

final class Auth {
    
    static func getRequestToken(url: String?, completion: @escaping (Result<String, Error>) -> Void){
        let apiKey = "a929d511c730708e667fd7fe46098969"
        
        let urlString: String = (url ?? "") + apiKey
        guard let url = URL(string: urlString) else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        var requestURL = URLRequest(url: url)
        let json: [String: Any] = [:]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        requestURL.httpMethod = "POST"
        requestURL.httpBody = jsonData
        requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requestURL.addValue("application/json", forHTTPHeaderField: "Accept")
        requestURL.setValue( "Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(CustomError.invalidData))
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
               let guestID = responseJSON.first { value in value.key == "guest_session_id" }
                guard let guestIDString = guestID?.value as? String else { return }
                print("💻\(responseJSON)")
                print("💻\(guestIDString)")
                completion(.success(guestIDString))
            }
        }
        task.resume()
    }
}
