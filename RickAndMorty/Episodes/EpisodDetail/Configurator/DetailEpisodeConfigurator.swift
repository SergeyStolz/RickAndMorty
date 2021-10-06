//
//  ConfigureEpisodeDetail.swift
//  RickAndMorty
//
//  Created by mac on 13.07.2021.
//

import UIKit

class DetailEpisodeConfigurator {
    
    static func create(charactersList: [String]) -> UIViewController {
        let view = DetailEpisodeViewController()
        let presenter = DetailEpisodePresenter()
        presenter.characterList = charactersList
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
