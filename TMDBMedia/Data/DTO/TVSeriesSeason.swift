//
//  TVSeriesSeason.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/17.
//

import Foundation

struct TVSeriesList: Decodable {
    let results: [TVSeries]
    
    init(results: [TVSeries] = []) {
        self.results = results
    }
}

struct TVSeries: Decodable {
    let name: String
    let id: Int
    let backdropPath: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case backdropPath = "backdrop_path"
    }
}

struct TVSeriesSeason: Decodable {
    let name: String
    let id: Int
    let seasons: [Season]
}

struct Season: Decodable {
    let name: String
    let posterPath: String?
    let seasonNumber: Int
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}

struct EpisodeList: Decodable {
    let episodes: [SeasonEpisode]
}

struct SeasonEpisode: Decodable {
    let id: Int
    let episodeNum: Int
    let stillPath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case episodeNum = "episode_number"
        case stillPath = "still_path"
    }
}
