//
//  EpisodesViewInput.swift
//  RickAndMorty
//
//  Created by mac on 20.07.2021.
//

import Foundation

protocol EpisodesViewInput {
    func succes()
    func failure(error: Error)
    func setupActivityView()
    func removeActivityView()
}
