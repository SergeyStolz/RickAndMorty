//
//  CharacterViewOutput.swift
//  RickAndMorty
//
//  Created by mac on 19.07.2021.
//

import UIKit

protocol CharacterViewOutput {
    func getCharacters()
    var characters: SearchResponseCharacters? { get set }
}
