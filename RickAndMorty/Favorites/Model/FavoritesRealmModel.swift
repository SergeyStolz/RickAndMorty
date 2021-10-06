//
//  Class.swift
//  RickAndMorty
//
//  Created by mac on 11.06.2021.
//

import Foundation
import RealmSwift

class FavoritesRealmModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var nameCharacter: String?
    @objc dynamic var statusCharacter: String?
    @objc dynamic var speciesCharacter: String?
    @objc dynamic var typeCharacter: String?
    @objc dynamic var genderCharacter: String?
    @objc dynamic var imageCharacter: Data? = nil
    @objc dynamic var state = false
}
