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
}
