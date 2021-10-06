//
//  SearchCharacterViewInput.swift
//  RickAndMorty
//
//  Created by GrowApp on 16.07.2021.
//

import Foundation

protocol SearchCharacterViewInput {
    var searchViewModelList: [SearchCharactersViewModel] { get set }
    func setupViews()
    func showSearchResults(with data: [SearchCharactersViewModel])
}
