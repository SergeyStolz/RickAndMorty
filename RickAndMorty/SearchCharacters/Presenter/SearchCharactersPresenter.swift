//
//  SearchCharactersPresenter.swift
//  RickAndMorty
//
//  Created by mac on 14.07.2021.
//

import Foundation

class SearchCharactersPresenter {
    
    var view: SearchCharacterViewInput?
    
    // MARK: - Private properties
    private var isRequestLocked = false
    private var searching = false
    let networkService = NetworkEpisodeDetailCharacter()
}

extension SearchCharactersPresenter: SearchCharacterViewOutput {
    
    func getSearchResult(_ text: String) {
        var searchViewModelList = [SearchCharactersViewModel]()
        let urlString = "https://rickandmortyapi.com/api/character/?name=\(text)"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                if let results = json["results"] as? Array<Any> {
                    for item in results {
                        guard let id = (item as? [String: Any])?["id"] as? Int else { return }
                        guard let name = (item as? [String: Any])?["name"] as? String else { return }
                        guard let image = (item as? [String: Any])?["image"] as? String else { return }
                        guard let status = (item as? [String: Any])?["status"] as? String else { return }
                        guard let species = (item as? [String: Any])?["species"] as? String else { return }
                        guard let type = (item as? [String: Any])?["type"] as? String else { return }
                        guard let gender = (item as? [String: Any])?["gender"] as? String else { return }
                        searchViewModelList.append(SearchCharactersViewModel(
                                                    id: id,
                                                    name: name,
                                                    image: image,
                                                    status: status,
                                                    species: species,
                                                    type: type,
                                                    gender: gender)
                        )
                    }
                }
                DispatchQueue.main.async {
                    self.view?.showSearchResults(with: searchViewModelList)
                }
            }
            catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
    }
    func viewLoaded() {
        view?.setupViews()
    }
}
