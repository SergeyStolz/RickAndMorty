//
//  SearchCharactersConfigurator.swift
//  RickAndMorty
//
//  Created by GrowApp on 16.07.2021.
//

import UIKit

class SearchCharactersConfigurator {
    static func create() -> UIViewController {
        let view = SearchCharactersViewController()
        let presenter = SearchCharactersPresenter()
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
