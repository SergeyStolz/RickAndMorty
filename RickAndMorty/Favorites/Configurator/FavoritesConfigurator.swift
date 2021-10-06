//
//  ConfigureFavorite.swift
//  RickAndMorty
//
//  Created by mac on 13.07.2021.
//

import UIKit

class FavoritesConfigurator {
    static func create() -> UIViewController {
        let view = FavoritesViewController()
        let presenter = FavoritesPresenter()
        view.presenter = presenter
        presenter.view = view
        return view
    }
}

