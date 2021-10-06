//
//  EpisodeViewOutput.swift
//  RickAndMorty
//
//  Created by mac on 20.07.2021.
//

import Foundation

protocol EpisodesViewOutput {
    func getEpisodes(isNew: Bool)
    var episodes: SearchRespondEpisode? { get set }
}
