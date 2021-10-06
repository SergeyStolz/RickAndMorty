//
//  FavoriteCellViewModel.swift
//  RickAndMorty
//
//  Created by mac on 14.07.2021.
//


import UIKit

struct FavoritesCellViewModel {
    var image = UIImage()
    var name = ""
    var status = ""
    var species = ""
    var type = ""
    var gender = ""
    var favorite = false
    
    init(_ items: FavoritesRealmModel) {
        guard let imageName = items.imageCharacter,
              let imageData = UIImage(data: imageName),
              let name = items.nameCharacter,
              let status = items.statusCharacter,
              let species = items.speciesCharacter,
              let type = items.typeCharacter,
              let gender = items.genderCharacter
        else {
            return
        }
        self.image = imageData
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.favorite = items.state
    }
}
