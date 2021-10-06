//
//  EpisodesPresenter.swift
//  RickAndMorty
//
//  Created by mac on 12.07.2021.
//

import UIKit

class EpisodesPresenter {
    var view: EpisodesViewController?
    let networkService = NetworkServiceEpisodes()
    var episodes: SearchRespondEpisode?
    var urlString = ""
    
    func getEpisodes(isNew: Bool) {
       if isNew == true {
            urlString = "https://rickandmortyapi.com/api/episode?page=1"
        } else {
            urlString = episodes?.info.next ?? ""
        }
        self.view?.setupActivityView()
        networkService.getEpisodes(urlString: urlString) { [weak self] result in
            self?.view?.removeActivityView()
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let episodes):
                    if isNew == true {
                        self.episodes = episodes
                    } else {
                        self.episodes?.results.append(contentsOf: episodes!.results)
                        self.episodes?.info = episodes!.info
                    }
                   self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error: error)
                    print(error)
                }
            }
        }
    }
}
