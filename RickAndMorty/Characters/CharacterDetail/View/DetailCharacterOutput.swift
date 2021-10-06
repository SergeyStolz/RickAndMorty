//
//  CharacterDetailOutput.swift
//  RickAndMorty
//
//  Created by mac on 20.07.2021.
//

import Foundation

protocol DetailCharacterOutput {
    var data: ResultsCharacter! { get set }
    func showItem()
}
