//
//  NetworkServiceEpisodeDetail.swift
//  RickAndMorty
//
//  Created by mac on 13.07.2021.
//

import Foundation

class NetworkEpisodeDetailCharacter {
    
    func getCharacters(url: String, completion: @escaping (Result<SearchRespondEpisodCharacter?, Error>) -> Void) {
        let urlString = url
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Some error")
                    //completion(nil, error)
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do{
                    let detailCharacter = try JSONDecoder().decode(SearchRespondEpisodCharacter.self, from: data)
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
