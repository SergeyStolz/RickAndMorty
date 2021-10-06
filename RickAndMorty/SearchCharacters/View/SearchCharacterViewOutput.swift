//
//  SearchCharacterViewOutput.swift
//  RickAndMorty
//
//  Created by GrowApp on 16.07.2021.
//

import UIKit

protocol SearchCharacterViewOutput {
    func viewLoaded()
    func getSearchResult(_ text: String)
}
