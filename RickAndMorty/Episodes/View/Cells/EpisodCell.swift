//
//  CustomEpisodCollectionViewCell.swift
//  RickAndMorty
//
//  Created by GrowApp on 31.05.2021.
//

import UIKit
import EasyPeasy

class EpisodCell: UICollectionViewCell {
    static let identifier = "CustomEpisodCollectionViewCell"
    
    let netWorkService = NetworkServiceEpisodes()
    let imageSearch = SearchResponseCharacters.self
    
    private var nameEpisodeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Hoefler Text", size: 22)
        label.numberOfLines = 0
        return label
    }()
    
    private var imageCircleEpisodeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Hoefler Text", size: 26)
        label.textColor = .white
        label.layer.cornerRadius = 30
        label.layer.masksToBounds = true
        label.backgroundColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(nameEpisodeLabel)
        contentView.addSubview(imageCircleEpisodeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameEpisodeLabel.easy.layout( Left(10).to(imageCircleEpisodeLabel), Right(10), CenterY(), Height(50) )
        imageCircleEpisodeLabel.easy.layout( Top(10), Left(10), Bottom(10), Width(60) )
    }
    
    func configure(label: String, imageLable: String) {
        nameEpisodeLabel.text = label
        imageCircleEpisodeLabel.text = imageLable
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameEpisodeLabel.text = nil
    }
}


