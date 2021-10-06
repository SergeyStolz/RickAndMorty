//
//  EpisodeDetailProtocol.swift
//  RickAndMorty
//
//  Created by mac on 13.07.2021.
//

import Foundation

class DetailEpisodePresenter: DetailEpisodeViewOutput {
    func updateBetsCollectionView(model: [SearchRespondEpisodCharacter]) {
    }
    
    var view: DetailEpisodeViewController?
    var characters: SearchRespondEpisodCharacter?
    let networkService = NetworkEpisodeDetailCharacter()
    var characterList = [String?]()
    var viewModel = [SearchRespondEpisodCharacter]()
    
    
    func getEpisodes() {
        for url in characterList {
            self.view?.setupActivityView()
            networkService.getCharacters(url: url ?? "") { [weak self] (result) in
                self?.view?.removeActivityView()
                switch result {
                case .success(let characters):
                    _ = [characters]
                    self?.characters = characters
                    self?.viewModel.append(characters!)
                    self?.view?.updateBetsCollectionView(model: self!.viewModel)
                    self?.view?.succes()
                case .failure(let error):
                    print("error", error)
                }
            }
        }
    }
}
