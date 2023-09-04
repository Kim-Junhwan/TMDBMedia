//
//  TVSeriesResponseDTO.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/09/04.
//

import Foundation

struct TVSeriesListResponseDTO: Decodable {
    let page: Int
    let totalPages: Int
    let tvSeriesList: [TVSeriesDTO]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case tvSeriesList = "results"
    }
}

struct TVSeriesDTO: Decodable {
    let id: Int
    let name: String
    let backdropPath: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case backdropPath = "backdrop_path"
    }
}

struct TVSeriesSeasonListResponseDTO: Decodable {
    let name: String
    let id: Int
    let seasons: [SeasonDTO]
    let backdropPath: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case backdropPath = "backdrop_path"
        case seasons
    }
    
    func toDomain() -> TVSeries {
        return .init(name: name, id: id, backdropPath: backdropPath, seasons: seasons.map { $0.toDomain() })
    }
}

struct SeasonDTO: Decodable {
    let name: String
    let posterPath: String?
    let seasonNumber: Int
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
    
    func toDomain() -> TVSeriesSeason {
        return TVSeriesSeason(name: name, posterPath: posterPath, seasonNumber: seasonNumber, id: id)
    }
}

struct EpisodeList: Decodable {
    let episodeList: [EpisodeDTO]
}

struct EpisodeDTO: Decodable {
    let id: Int
    let episodeNumber: Int
    let stillPath: String
}
