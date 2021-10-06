//
//  CharacterViewInput.swift
//  RickAndMorty
//
//  Created by mac on 19.07.2021.
//

import UIKit

protocol CharacterViewInput {
    func reloadData()
    func failure(error: Error)
    func succes()
}
