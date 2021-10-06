//
//  NetworkServiceSearchCharacters.swift
//  RickAndMorty
//
//  Created by GrowApp on 15.07.2021.
//
import Foundation

class NetworkServiceSearchCharacters {
    
    func getSearchCharacters(text: String, completion: @escaping (Result<SearchRespondEpisode?, Error>) -> Void) {
        
        let urlString = "https://rickandmortyapi.com/api/character/?name=\(text)"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                if let results = json["results"] as? Array<Any> {
                    DispatchQueue.main.async {
                        for item in results {
                            guard let name = (item as? [String: Any])?["name"] as? String else { return }
                            guard let image = (item as? [String: Any])?["image"] as? String else { return }
                        }
                    }
                }
            }
            catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
    }
}

