//
//  CharactersCustomViewModel.swift
//  RickAndMorty
//
//  Created by GrowApp on 27.07.2021.
//

import UIKit
import RealmSwift

struct CharactersCellViewModel {
    var id: Int
    var name: String
    var image: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var isFavorite = false
    
    init(_ item: ResultsCharacter) {
        self.id = item.id
        self.image = item.image
        self.name =  item.name
        self.status = item.status
        self.species = item.species
        self.type = item.type
        self.gender = item.gender
        
        let realm = try? Realm()
        let items = realm?.objects(FavoritesRealmModel.self)
        
        if let searchResults = items?.filter({$0.id == item.id}) {
            self.isFavorite = searchResults.isEmpty ? false : true
        }
    }
}
