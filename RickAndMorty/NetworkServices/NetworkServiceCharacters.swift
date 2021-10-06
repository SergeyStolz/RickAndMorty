//
//  NetworkServiceCharacters.swift
//  RickAndMorty
//
//  Created by mac on 19.07.2021.
//

import UIKit

class NetworkServiceCharacter {
    
    func getCharacters(urlString: String, completion: @escaping (Result<SearchResponseCharacters, Error>) -> Void) {
        
        let urlString = urlString
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do{
                    let detailCharacter = try JSONDecoder().decode(SearchResponseCharacters.self, from: data)
                    completion(.success(detailCharacter))
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }
        .resume()
    }
}



