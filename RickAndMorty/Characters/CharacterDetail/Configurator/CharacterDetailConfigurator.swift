//
//  CharactersConfigurator.swift
//  RickAndMorty
//
//  Created by mac on 20.07.2021.
//

import UIKit

class CharacterDetailConfigurator {
    
    static func create(data: ResultsCharacter?) -> UIViewController {
        let view = DetailCharacterViewController()
        let presenter = DetailCharacterPresenter()
        presenter.data = data
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
