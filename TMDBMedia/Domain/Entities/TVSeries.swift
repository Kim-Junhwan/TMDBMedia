//
//  TVSeries.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/09/04.
//

import Foundation

struct TVSeriesPage {
    let page: Int
    let totalPages: Int
    let tvSeriesList: [TVSeries]
}

struct TVSeries {
    let name: String
    let id: Int
    let backdropPath: String
    let seasons: [TVSeriesSeason]
}

struct TVSeriesSeason {
    let name: String
    let posterPath: String?
    let seasonNumber: Int
    let id: Int
}

struct SeasonEpisodeList{
    let episodes: [SeasonEpisode]
}

struct SeasonEpisode {
    let id: Int
    let episodeNum: Int
    let stillPath: String?
}
