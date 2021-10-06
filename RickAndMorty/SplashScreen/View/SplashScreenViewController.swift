//
//  SplashScreenViewController.swift
//  RickAndMorty
//
//  Created by GrowApp on 10.06.2021.
//

import UIKit
import EasyPeasy

class SplashScreenViewController: UIViewController {
    
    var presenter: SplashScreenViewOutput!
    
    private lazy var splashScreenimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Launch.png")
        return imageView
    }()
    
    private lazy var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.hidesWhenStopped = true
        activityView.center = self.view.center
        activityView.color = .white
        activityView.startAnimating()
        return activityView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(splashScreenimageView)
        setupImageViewSplashScreen()
        setupActivityView()
        presenter.loadInitialCharacters()
    }
    
    private func setupImageViewSplashScreen() {
        splashScreenimageView.easy.layout( Edges() )
    }
}

extension SplashScreenViewController: SplashScreenViewInput {
    
    func setupActivityView() {
        view.addSubview(activityView)
        activityView.easy.layout(
            CenterX(),
            Bottom((view.frame.size.height / 2) - (view.frame.size.height / 4)).to(view.safeAreaLayoutGuide, .bottom)
        )
    }
    
    func removeActivityView() {
        activityView.stopAnimating()
        activityView.removeFromSuperview()
    }
    
    func succes(characters: SearchResponseCharacters) {
        let tabBarVC = TabBarVC()
        tabBarVC.start(characters: characters)
        tabBarVC.modalTransitionStyle = .crossDissolve
        tabBarVC.modalPresentationStyle = .fullScreen
        self.present(tabBarVC, animated: false, completion: nil)
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
}
