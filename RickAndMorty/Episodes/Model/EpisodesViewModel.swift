//
//  NetworkServiceEpisode.swift
//  RickAndMorty
//
//  Created by mac on 06.06.2021.
//

import UIKit

struct SearchRespondEpisode: Decodable {
    var info: InfoEpisode
    var results: [ResultsEpisode]
}
struct InfoEpisode: Decodable {
    var count : Int
    var pages : Int
    var next : String?
    var prev : String?
}
struct ResultsEpisode: Decodable {
    var id : Int
    var name : String
    var airDate : String
    var episode : String
    var characters : [String]
    var url : String
    var created : String
    
    
    private enum CodingKeys : String, CodingKey {
        case id,
             name,
             airDate = "air_date",
             episode,
             characters,
             url,
             created
    }
}
