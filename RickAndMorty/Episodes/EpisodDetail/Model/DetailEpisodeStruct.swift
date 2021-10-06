//
//  NetworkServiceEpicChar.swift
//  RickAndMorty
//
//  Created by mac on 06.06.2021.
//

import Foundation

struct SearchRespondEpisodCharacter: Decodable {
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



