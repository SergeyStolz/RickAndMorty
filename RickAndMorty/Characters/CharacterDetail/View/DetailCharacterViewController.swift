//
//  AllCharactersDetailVC.swift
//  RickAndMorty
//
//  Created by mac on 06.06.2021.
//

import UIKit
import EasyPeasy

class DetailCharacterViewController: UIViewController, UIScrollViewDelegate {
    
    var presenter: DetailCharacterPresenter!
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = UIStackView.Alignment.leading
        stackView.backgroundColor = .systemGray6
        stackView.spacing = 17
        return stackView
    }()
    
    private lazy var headView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private lazy var detailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = UIStackView.Alignment.leading
        stackView.backgroundColor = .systemGray6
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 0.2
        imageView.layer.cornerRadius = 13
        return imageView
    }()
    
    private lazy var nameCharacterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Hoefler Text", size: 28)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var statusCharacterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Hoefler Text", size: 24)
        label.layoutMargins = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 0)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var statusCircleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.layer.cornerRadius = 6
        label.layer.masksToBounds = true
        return label
    }()
    
    private lazy var speciesCharacterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Hoefler Text", size: 24)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var typeCharacterLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Hoefler Text", size: 24)
        return label
    }()
    
    private lazy var genderCharacterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Hoefler Text", size: 24)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationController()
        setupViews()
        setupConstraints()
    }
    
    func setupNavigationController() {
        title = "Character Details"
        let navController = UINavigationController()
        navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.init(name: "Hoefler Text", size: 25)!]
    }
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(headView)
        headView.addSubview(characterImageView)
        headView.addSubview(nameCharacterLabel)
        headView.addSubview(statusCircleLabel)
        mainStackView.addArrangedSubview(detailStackView)
        detailStackView.addArrangedSubview(statusCharacterLabel)
        detailStackView.addArrangedSubview(speciesCharacterLabel)
        detailStackView.addArrangedSubview(typeCharacterLabel)
        detailStackView.addArrangedSubview(genderCharacterLabel)
        
        nameCharacterLabel.text = presenter.data.name
        statusCharacterLabel.text = presenter.data.status
        speciesCharacterLabel.text = presenter.data.species
        genderCharacterLabel.text = presenter.data.gender
        
        let urlString = presenter.data.image
        guard let url = URL(string: urlString)  else { return }
        if let data = NSData(contentsOf: url) {
            characterImageView.image = UIImage(data: data as Data)!
        }
        
        if presenter.data.status == "Alive" {
            statusCircleLabel.backgroundColor = .green
        } else if presenter.data.status == "unknown" {
            statusCircleLabel.backgroundColor = .brown
        }  else if presenter.data.status == "Dead" {
            statusCircleLabel.backgroundColor = .red
        }
        
        if presenter.data.type == "" {
            typeCharacterLabel.text = "Type: Unknow"
        } else {
            typeCharacterLabel.text = presenter.data.type
        }
    }
    
    func setupConstraints() {
        scrollView.easy.layout( Edges() )
        mainStackView.easy.layout( Edges(), Width(view.frame.size.width) )
        headView.easy.layout( Top(), Left(), Right(), Height(view.frame.size.height/1.5) )
        characterImageView.easy.layout( Left(10).to(headView), Right(10).to(headView), Top(10).to(headView), Bottom(50).to(headView) )
        nameCharacterLabel.easy.layout( CenterX(), Top(10).to(characterImageView), Height(30), Width(<=view.frame.size.width) )
        statusCircleLabel.easy.layout( Right(7).to(nameCharacterLabel), Top(17).to(characterImageView), Height(12), Width(12) )
        detailStackView.easy.layout( Top(5).to(headView), Left(15), Right(15), Bottom(15) )
    }
}
