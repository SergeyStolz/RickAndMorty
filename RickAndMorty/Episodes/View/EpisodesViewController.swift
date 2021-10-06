//
//  AllEpisodesVC.swift
//  RickAndMorty
//
//  Created by GrowApp on 31.05.2021.
//

import UIKit
import EasyPeasy

class EpisodesViewController: UIViewController {
    
    var presenter: EpisodesPresenter!
    var episodes: SearchRespondEpisode?
    
    // MARK: - Views
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width ,
                                 height: 80
        )
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(
            EpisodCell.self,
            forCellWithReuseIdentifier: EpisodCell.identifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    private lazy var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.hidesWhenStopped = true
        activityView.center = self.view.center
        return activityView
    }()
    
    private lazy var fadeView: UIView = {
        let fadeView:UIView = UIView()
        fadeView.frame = self.view.frame
        fadeView.backgroundColor = UIColor.white
        fadeView.alpha = 0.4
        return fadeView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.easy.layout( Edges() )
        presenter.getEpisodes(isNew: true)
    }
}

extension EpisodesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        guard let charactersName = presenter.episodes?.results[indexPath.row].characters else { return }
        let episodeDetail = DetailEpisodeConfigurator.create(charactersList: charactersName)
        self.navigationController?.pushViewController(episodeDetail, animated: true)
    }
}

extension EpisodesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return presenter.episodes?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EpisodCell.identifier,
            for: indexPath) as! EpisodCell
        
        let episodes = presenter.episodes?.results[indexPath.item]
        cell.configure(label: episodes!.name,
                       imageLable: "#\(indexPath.item + 1)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let totalCount = presenter.episodes?.info.count ?? 0
        let currentCount = presenter.episodes?.results.count ?? 0
        
        if indexPath.item == currentCount - 1 {
            if currentCount < totalCount {
                presenter.getEpisodes(isNew: false)
            }
        }
    }
}

extension EpisodesViewController: EpisodesViewInput {
    
    func setupActivityView() {
        view.addSubview(fadeView)
        view.addSubview(activityView)
        activityView.easy.layout(
            CenterX(),
            CenterY()
        )
        activityView.startAnimating()
    }
    
    func removeActivityView() {
        fadeView.removeFromSuperview()
        activityView.stopAnimating()
    }
    
    func succes() {
        collectionView.reloadData()
    }
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

