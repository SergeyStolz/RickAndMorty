//
//  TabBarVC.swift
//  RickAndMorty
//
//  Created by GrowApp on 31.05.2021.
//

import UIKit

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
    }
    
    func start(characters: SearchResponseCharacters?) {
        guard let characters = characters else { return }
        viewControllers = [
            createNavController(
                for: CharactersConfigurator.create(characters: characters),
                title: NSLocalizedString("Characters", comment: ""),
                image: UIImage(systemName: "person.3.fill")!),
            createNavController(
                for: EpisodesConfigurator.create(),
                title: NSLocalizedString("Episodes", comment: ""),
                image: UIImage(systemName: "film")!),
            createNavController(
                for: SearchCharactersConfigurator.create(),
                title: NSLocalizedString("Search characters", comment: ""),
                image: UIImage(systemName: "magnifyingglass")!),
            createNavController(
                for: FavoritesConfigurator.create(),
                title: NSLocalizedString("Favourites", comment: ""),
                image: UIImage(systemName: "star.fill")!)
            
        ]
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)]
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        
        return navController
    }
    
}

