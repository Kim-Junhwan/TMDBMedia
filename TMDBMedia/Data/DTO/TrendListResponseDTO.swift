//
//  TrendListDTO.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/12.
//

import Foundation

struct TrendListResponseDTO: Codable {
    let trendList: [TrendDTO]
    let page: Int
    let totalPages: Int
    
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case trendList = "results"
    }
    
    func toDomain() -> TrendPage {
        return .init(page: page, totalPages: totalPages, mediaList: trendList.map { $0.toDomain() })
    }
}

struct TrendDTO: Codable {
    
    let media_type: String
    let poster_path: String
    let vote_count: Int
    let original_language: String
    let backdrop_path: String
    let overview: String
    let id: Int
    
    //media가 movie일떄
    let title: String?
    let release_date: String?
    let original_title: String?
    
    //media가 tv일때
    let name: String?
    let first_air_date: String?
    let original_name: String?
    
    func toDomain() -> Media {
        let title: String
        let originalTitle: String
        let releaseDate: String
        let mediaType: Media.MediaType = Media.MediaType(rawValue: media_type) ?? .movie
        
        switch mediaType {
        case .movie:
            title = self.title ?? ""
            releaseDate = self.release_date ?? ""
            originalTitle = self.original_title ?? ""
        case .tv:
            title = self.name ?? ""
            releaseDate = self.first_air_date ?? ""
            originalTitle = self.original_name ?? ""
        }
        
        return Media(id: id, title: title, originalTitle: originalTitle, mediaType: mediaType, posterPath: poster_path, backdropPath: backdrop_path, voteCount: vote_count, originalLanguage: original_language, overview: overview, releaseDate: releaseDate)
    }
    
}
