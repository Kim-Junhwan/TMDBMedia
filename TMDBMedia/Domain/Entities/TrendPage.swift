//
//  TrendList.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/09/02.
//

import Foundation

struct TrendPage {
    let page: Int
    let totalPages: Int
    let mediaList: [Media]
    
    enum CodingKeys: String, CodingKey {
        case mediaList = "results"
    }
    
    init() {
        self.page = 0
        self.totalPages = 0
        self.mediaList = []
    }
    
    init(page: Int, totalPages: Int, mediaList: [Media]) {
        self.page = page
        self.totalPages = totalPages
        self.mediaList = mediaList
    }
    
}

struct Media: Identifiable {
    enum MediaType: String {
        case movie
        case tv
    }
    
    let id: Int
    
    let title: String
    let originalTitle: String
    
    let mediaType: MediaType
    
    let posterPath: String
    let backdropPath: String
    
    let voteCount: Int
    let originalLanguage: String
    let overview: String
    let releaseDate: String
    
}
