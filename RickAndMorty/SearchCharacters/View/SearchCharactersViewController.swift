//
//  SearchCharactersViewController.swift
//  RickAndMorty
//
//  Created by mac on 12.07.2021.
//

import UIKit
import EasyPeasy
import RealmSwift

class SearchCharactersViewController: UIViewController, SearchCharacterViewInput, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Properties
    var presenter: SearchCharacterViewOutput!
    var searchViewModelList = [SearchCharactersViewModel]()
    let detailView = DetailCharacterView()
    
    // MARK: - Views
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        return searchController
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 100
        tableView.register(SearchCharactersViewControllerCell.self,
                           forCellReuseIdentifier: SearchCharactersViewControllerCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
        configureTapGesture()
    }
    
    override func viewWillLayoutSubviews() {
        detailView.easy.layout( Top(view.frame.size.height/5), Bottom(view.frame.size.height/5), CenterX(), Width(350) )
    }
    
    internal func setupViews() {
        view.addSubview(tableView)
        view.addSubview(searchController.searchBar)
        tableView.easy.layout( Edges() )
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    internal func showSearchResults(with data: [SearchCharactersViewModel]) {
        self.searchViewModelList = data
        self.tableView.reloadData()
        print(self.searchViewModelList.count)
    }
    
    private func setupDetailCharacterView() {
        view.addSubview(detailView)
        detailView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        detailView.alpha = 0
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.detailView.alpha = 1
            self.detailView.transform = CGAffineTransform.identity
        }
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showDetailCharacterView))
        detailView.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func showDetailCharacterView() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else { return }
            self.detailView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
            self.detailView.alpha = 0
        }
        ) { (success) in
            self.detailView.removeFromSuperview()
        }
    }
    
    // MARK: - TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchViewModelList.count == 0 {
            setEmptyMessage("Enter the name of the character\n you are looking for, or part of it")
        } else {
            setEmptyMessage("")
        }
        return searchViewModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCharactersViewControllerCell.identifier,for: indexPath) as! SearchCharactersViewControllerCell
        
        cell.fill(item: searchViewModelList[indexPath.row])
        cell.accessoryType = UITableViewCell.AccessoryType.detailButton
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.1
        cell.layer.cornerRadius = 7
        cell.tintColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let item = searchViewModelList[indexPath.row]
        detailView.nameCharacterLabel.text = item.name
        detailView.speciesCharacterLabel.text = "Species: \(item.species)"
        detailView.statusCharacterLabel.text = "Status: \(item.status)"
        detailView.genderCharacterLabel.text = "Gender: \(item.gender)"
        detailView.idCharacterLabel.text = "\(item.id)"
        
        if item.status == "Alive" {
            detailView.statusCircleLabel.backgroundColor = .green
        } else if item.status == "unknown" {
            detailView.statusCircleLabel.backgroundColor = .brown
        }  else if item.status == "Dead" {
            detailView.statusCircleLabel.backgroundColor = .red
        }
        
        if item.type == "" {
            detailView.typeCharacterLabel.text = "Type: Unknow"
        } else {
            detailView.typeCharacterLabel.text = "Type: \(item.type)"
        }
        
        let urlString = item.image
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            if let data = NSData(contentsOf: url) {
                DispatchQueue.main.async {
                    self.detailView.characterImageView.image = UIImage(data: data as Data)
                }
            }
        }
        setupDetailCharacterView()
    }
}

// MARK: - SearchControllerDelegate
extension SearchCharactersViewController: UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
        let text = searchController.searchBar.text ?? ""
        let textwithPercentEscapes = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        presenter.getSearchResult(textwithPercentEscapes!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchViewModelList.removeAll()
        tableView.reloadData()
    }
}

extension SearchCharactersViewController {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(
            frame: CGRect(
                origin: .zero,
                size: CGSize(
                    width: view.frame.size.width,
                    height: view.frame.size.width)
            )
        )
        messageLabel.frame = view.bounds
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 19)
        messageLabel.sizeToFit()
        
        tableView.backgroundView = messageLabel
        tableView.separatorStyle = .none
    }
}



