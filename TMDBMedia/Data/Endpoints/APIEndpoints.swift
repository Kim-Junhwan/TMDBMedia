//
//  APIEndpoints.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/09/03.
//

import Foundation

struct APIEndpoints {
    static func fetchTrendList(trendListRequestDTO: TrendListRequestDTO) -> EndPoint<TrendListResponseDTO> {
        return EndPoint(path: "/3/trending/all/day", method: .GET, query: trendListRequestDTO)
    }
    
    static func fetchDetailMedia(detailReqeustDTO: DetailMediaRequestDTO) -> EndPoint<DetailMediaResponseDTO> {
        return EndPoint(path: "3/movie/\(detailReqeustDTO.id)/credits", method: .GET, query: nil)
    }
    
    static func fetchTVSeriesList(tvseriesListRequestDTO: TVSeriesListRequestDTO) -> EndPoint<TVSeriesListResponseDTO> {
        return EndPoint(path: "3/tv/top_rated", method: .GET, query: tvseriesListRequestDTO)
    }
    
    static func fetchTVSeriesSeason(tvSeriesSeasonsRequestDTO: TVseriesSeasonsRequestDTO) -> EndPoint<TVSeriesSeasonListResponseDTO> {
        return EndPoint(path: "3/tv/\(tvSeriesSeasonsRequestDTO.id)", method: .GET, query: nil)
    }
}
