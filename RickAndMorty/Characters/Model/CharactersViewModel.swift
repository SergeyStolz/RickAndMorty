//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by GrowApp on 01.06.2021.
//

import Foundation

struct SearchResponseCharacters: Decodable {
    var info: InfoCharacter
    var results: [ResultsCharacter]
}
struct InfoCharacter: Decodable {
    var count : Int
    var pages : Int
    var next : String?
    var prev : String?
}

struct ResultsCharacter: Decodable {
    var id : Int
    var name : String
    var status : String
    var species : String
    var type : String
    var gender : String
    var url : String
    var created : String
    var image : String
}
