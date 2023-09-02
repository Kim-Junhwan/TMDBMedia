//
//  TrendList.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/09/02.
//

import Foundation

struct TrendPage {
    let page: Int
    let totalPage: Int
    let mediaList: [Media]
    
    enum CodingKeys: String, CodingKey {
        case mediaList = "results"
    }
}

struct Media: Identifiable {
    enum MediaType {
        case movie
        case tv
    }
    
    let id: Int
    
    let title: String
    let original_title: String
    
    let mediaType: MediaType
    
    let poster_path: String
    let backdrop_path: String
    
    let vote_count: Int
    let original_language: String
    let overview: String
    let release_date: String
    
}
