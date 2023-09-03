//
//  TrendListDTO.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/12.
//

import Foundation

struct TrendListResponseDTO: Codable {
    private let results: [TrendDTO]
    var count: Int {
        get {
            results.count
        }
    }
    
    func getMovieForIndex(index: Int) -> TrendDTO {
        return results[index]
    }
    
    init(results: [TrendDTO]) {
        self.results = results
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
    
}
