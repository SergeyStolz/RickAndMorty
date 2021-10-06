//
//  ModelBuilder.swift
//  RickAndMorty
//
//  Created by mac on 12.07.2021.
//
import UIKit


class EpisodesConfigurator {

    static func create() -> UIViewController {
        let view = EpisodesViewController()
        let presenter = EpisodesPresenter()
        view.presenter = presenter
        presenter.view = view
        return view
    }
}

