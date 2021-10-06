//
//  SplashScreenConfigurator.swift
//  RickAndMorty
//
//  Created by mac on 28.07.2021.
//

import UIKit

class SplashScreenConfigurator {
    static func create() -> UIViewController {
        let view = SplashScreenViewController()
        let presenter = PresenterSplashScreen()
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
