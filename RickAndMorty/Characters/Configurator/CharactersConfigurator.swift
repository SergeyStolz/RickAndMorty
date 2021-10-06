//
//  CharactersConfigurator.swift
//  RickAndMorty
//
//  Created by mac on 19.07.2021.
//

import UIKit

class CharactersConfigurator {
    static func create(characters: SearchResponseCharacters) -> UIViewController {
        let view = CharactersViewController()
        let presenter = CharactersPresenter()
        presenter.characters = characters
        view.presenter = presenter
        presenter.view = view
        return view
    }
}

