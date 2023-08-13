//
//  Movie.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/12.
//

import Foundation

struct MovieList: Decodable {
    private let results: [Movie]
    var count: Int {
        get {
            results.count
        }
    }
    
    func getMovieForIndex(index: Int) -> Movie {
        return results[index]
    }
    
    init(results: [Movie]) {
        self.results = results
    }
}

struct Movie: Decodable {
    let title: String
    let release_date: String
    let poster_path: String
    let vote_count: Int
    let original_language: String
    let backdrop_path: String
    let overview: String
    let id: Int
}
