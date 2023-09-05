//
//  TVSeriesRequestDTO.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/09/04.
//

import Foundation

struct TVSeriesListRequestDTO: Encodable {
    let page: Int
}

struct TVseriesSeasonsRequestDTO: Encodable {
    let id: Int
}

struct TVSeriesSeasonEpsodeRequestDTO: Encodable {
    let tvSeriesId: Int
    let seasonNumber: Int
}
