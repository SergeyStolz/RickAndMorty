//
//  CharactersPresenter.swift
//  RickAndMorty
//
//  Created by mac on 19.07.2021.
//

import UIKit
import RealmSwift

class CharactersPresenter: CharacterViewOutput {
    var view: CharactersViewController?
    var characters: SearchResponseCharacters?
    let networkService = NetworkServiceCharacter()
    
    func getCharacters() {
        let urlString = characters?.info.next ?? ""
        networkService.getCharacters(urlString: urlString) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let characters):
                    self.characters?.results.append(contentsOf: characters.results)
                    self.characters?.info = characters.info
                    print(characters.results)
                    self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error: error)
                    
                }
            }
        }
    }
}
