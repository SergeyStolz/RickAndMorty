//
//  DetailEpisodeViewModel.swift
//  RickAndMorty
//
//  Created by mac on 14.09.2021.
//

import UIKit

struct DetailEpisodeViewModel {
    var id: Int
    var name: String
    var image: String
    var status: String
    var species: String
    var type: String
    var gender: String
    
    init(item: SearchRespondEpisodCharacter) {
        self.id = item.id
        self.name = item.name
        self.image = item.image
        self.status = item.status
        self.species = item.species
        self.type = item.type
        self.gender = item.gender
    }
}
