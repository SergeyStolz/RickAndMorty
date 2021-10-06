//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by mac on 12.07.2021.
//

import Foundation

class NetworkServiceEpisodes {
    
    func getEpisodes(urlString: String, completion: @escaping (Result<SearchRespondEpisode?, Error>) -> Void) {
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
                    let detailEpisode = try JSONDecoder().decode(SearchRespondEpisode.self, from: data)
                    completion(.success(detailEpisode))
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }
        .resume()
    }
}

