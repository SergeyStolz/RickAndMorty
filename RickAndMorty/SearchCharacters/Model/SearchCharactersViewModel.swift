//
//  SearchCharactersViewModel.swift
//  RickAndMorty
//
//  Created by GrowApp on 15.07.2021.
//

import UIKit
import RealmSwift

struct SearchCharactersViewModel {
    var id: Int
    var name: String
    var image: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var isFavorite = false
    
    init(id: Int,
         name: String,
         image: String,
         status: String,
         species: String,
         type: String,
         gender: String
    ){
        self.id = id
        self.name = name
        self.image = image
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        
        let realm = try? Realm()
        let items = realm?.objects(FavoritesRealmModel.self)
        
        if let searchResults = items?.filter({$0.id == id}) {
            self.isFavorite = searchResults.isEmpty ? false : true
        }
    }
}
