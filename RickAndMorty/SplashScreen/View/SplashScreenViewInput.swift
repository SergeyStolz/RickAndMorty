//
//  SplashScreenViewInput.swift
//  RickAndMorty
//
//  Created by mac on 28.07.2021.
//

import Foundation

protocol SplashScreenViewInput {
    func failure(error: Error)
    func succes(characters: SearchResponseCharacters)
    func setupActivityView()
    func removeActivityView()
}
